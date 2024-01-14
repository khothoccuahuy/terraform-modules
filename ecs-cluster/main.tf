################################################################################
# Cluster
################################################################################

# module "cluster" {
#   source = "./cluster"

#   create = var.create

#   # Cluster
#   cluster_name                     = var.cluster_name
#   cluster_configuration            = var.cluster_configuration
#   cluster_settings                 = var.cluster_settings
#   cluster_service_connect_defaults = var.cluster_service_connect_defaults

#   # Cluster Cloudwatch log group
#   create_cloudwatch_log_group            = var.create_cloudwatch_log_group
#   cloudwatch_log_group_retention_in_days = var.cloudwatch_log_group_retention_in_days
#   cloudwatch_log_group_kms_key_id        = var.cloudwatch_log_group_kms_key_id
#   cloudwatch_log_group_tags              = var.cloudwatch_log_group_tags

#   # Cluster capacity providers
#   default_capacity_provider_use_fargate = var.default_capacity_provider_use_fargate
#   fargate_capacity_providers            = var.fargate_capacity_providers
#   autoscaling_capacity_providers        = var.autoscaling_capacity_providers

#   # Task execution IAM role
#   create_task_exec_iam_role               = var.create_task_exec_iam_role
#   task_exec_iam_role_name                 = var.task_exec_iam_role_name
#   task_exec_iam_role_use_name_prefix      = var.task_exec_iam_role_use_name_prefix
#   task_exec_iam_role_path                 = var.task_exec_iam_role_path
#   task_exec_iam_role_description          = var.task_exec_iam_role_description
#   task_exec_iam_role_permissions_boundary = var.task_exec_iam_role_permissions_boundary
#   task_exec_iam_role_tags                 = var.task_exec_iam_role_tags
#   task_exec_iam_role_policies             = var.task_exec_iam_role_policies

#   # Task execution IAM role policy
#   create_task_exec_policy  = var.create_task_exec_policy
#   task_exec_ssm_param_arns = var.task_exec_ssm_param_arns
#   task_exec_secret_arns    = var.task_exec_secret_arns
#   task_exec_iam_statements = var.task_exec_iam_statements

#   tags = merge(var.tags, var.cluster_tags)
# }

################################################################################
#     https://github.com/terraform-aws-modules/terraform-aws-ecs/tree/v5.2.0   #
################################################################################
data "aws_partition" "current" {}

################################################################################
# Cluster
################################################################################

locals {
  execute_command_configuration = {
    logging = "OVERRIDE"
    log_configuration = {
      cloud_watch_log_group_name = try(aws_cloudwatch_log_group.this[0].name, null)
    }
  }
}

resource "aws_ecs_cluster" "this" {
  count = var.create ? 1 : 0

  name = var.cluster_name

  dynamic "configuration" {
    for_each = var.create_cloudwatch_log_group ? [var.cluster_configuration] : []

    content {
      dynamic "execute_command_configuration" {
        for_each = try([merge(local.execute_command_configuration, configuration.value.execute_command_configuration)], [{}])

        content {
          kms_key_id = try(execute_command_configuration.value.kms_key_id, null)
          logging    = try(execute_command_configuration.value.logging, "DEFAULT")

          dynamic "log_configuration" {
            for_each = try([execute_command_configuration.value.log_configuration], [])

            content {
              cloud_watch_encryption_enabled = try(log_configuration.value.cloud_watch_encryption_enabled, null)
              cloud_watch_log_group_name     = try(log_configuration.value.cloud_watch_log_group_name, null)
              s3_bucket_name                 = try(log_configuration.value.s3_bucket_name, null)
              s3_bucket_encryption_enabled   = try(log_configuration.value.s3_bucket_encryption_enabled, null)
              s3_key_prefix                  = try(log_configuration.value.s3_key_prefix, null)
            }
          }
        }
      }
    }
  }

  dynamic "configuration" {
    for_each = !var.create_cloudwatch_log_group && length(var.cluster_configuration) > 0 ? [var.cluster_configuration] : []

    content {
      dynamic "execute_command_configuration" {
        for_each = try([configuration.value.execute_command_configuration], [{}])

        content {
          kms_key_id = try(execute_command_configuration.value.kms_key_id, null)
          logging    = try(execute_command_configuration.value.logging, "DEFAULT")

          dynamic "log_configuration" {
            for_each = try([execute_command_configuration.value.log_configuration], [])

            content {
              cloud_watch_encryption_enabled = try(log_configuration.value.cloud_watch_encryption_enabled, null)
              cloud_watch_log_group_name     = try(log_configuration.value.cloud_watch_log_group_name, null)
              s3_bucket_name                 = try(log_configuration.value.s3_bucket_name, null)
              s3_bucket_encryption_enabled   = try(log_configuration.value.s3_bucket_encryption_enabled, null)
              s3_key_prefix                  = try(log_configuration.value.s3_key_prefix, null)
            }
          }
        }
      }
    }
  }

  dynamic "service_connect_defaults" {
    for_each = length(var.cluster_service_connect_defaults) > 0 ? [var.cluster_service_connect_defaults] : []

    content {
      namespace = service_connect_defaults.value.namespace
    }
  }

  dynamic "setting" {
    for_each = [var.cluster_settings]

    content {
      name  = setting.value.name
      value = setting.value.value
    }
  }

  tags = var.tags
}

################################################################################
# Cluster Capacity Providers
################################################################################

locals {
  default_capacity_providers = merge(
    { for k, v in var.fargate_capacity_providers : k => v if var.default_capacity_provider_use_fargate },
    { for k, v in var.autoscaling_capacity_providers : k => v if !var.default_capacity_provider_use_fargate }
  )
}
resource "aws_ecs_cluster_capacity_providers" "this" {
  count = var.create && length(merge(var.fargate_capacity_providers, var.autoscaling_capacity_providers)) > 0 ? 1 : 0

  cluster_name = aws_ecs_cluster.this[0].name
  capacity_providers = distinct(concat(
    [for k, v in var.fargate_capacity_providers : try(v.name, k)],
    [for k, v in var.autoscaling_capacity_providers : try(v.name, k)]
  ))

  # https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cluster-capacity-providers.html#capacity-providers-considerations
  dynamic "default_capacity_provider_strategy" {
    for_each = local.default_capacity_providers
    iterator = strategy

    content {
      capacity_provider = try(strategy.value.name, strategy.key)
      base              = try(strategy.value.default_capacity_provider_strategy.base, null)
      weight            = try(strategy.value.default_capacity_provider_strategy.weight, null)
    }
  }

  depends_on = [
    aws_ecs_capacity_provider.this
  ]
}

################################################################################
# Capacity Provider - Autoscaling Group(s)
################################################################################

resource "aws_ecs_capacity_provider" "this" {
  for_each = { for k, v in var.autoscaling_capacity_providers : k => v if var.create }

  name = try(each.value.name, each.key)

  auto_scaling_group_provider {
    auto_scaling_group_arn = each.value.auto_scaling_group_arn
    # When you use managed termination protection, you must also use managed scaling otherwise managed termination protection won't work
    managed_termination_protection = length(try([each.value.managed_scaling], [])) == 0 ? "DISABLED" : try(each.value.managed_termination_protection, null)

    dynamic "managed_scaling" {
      for_each = try([each.value.managed_scaling], [])

      content {
        instance_warmup_period    = try(managed_scaling.value.instance_warmup_period, null)
        maximum_scaling_step_size = try(managed_scaling.value.maximum_scaling_step_size, null)
        minimum_scaling_step_size = try(managed_scaling.value.minimum_scaling_step_size, null)
        status                    = try(managed_scaling.value.status, null)
        target_capacity           = try(managed_scaling.value.target_capacity, null)
      }
    }
  }

  tags = merge(var.tags, try(each.value.tags, {}))
}

################################################################################
# CloudWatch Log Group
################################################################################

resource "aws_cloudwatch_log_group" "this" {
  count = var.create && var.create_cloudwatch_log_group ? 1 : 0

  name              = "/aws/ecs/${var.cluster_name}"
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  kms_key_id        = var.cloudwatch_log_group_kms_key_id

  tags = merge(var.tags, var.cloudwatch_log_group_tags)
}