resource "aws_rds_cluster" "this" {
  cluster_identifier               = var.db_cluster_identifier
  engine                           = var.db_cluster_engine
  engine_mode                      = var.db_cluster_engine_mode
  engine_version                   = var.db_cluster_engine_version
  storage_type                     = var.db_cluster_storage_type
  allocated_storage                = var.db_cluster_allocated_storage
  iops                             = var.db_cluster_iops
  availability_zones               = var.db_cluster_azs
  copy_tags_to_snapshot            = var.db_cluster_copy_tags_to_snapshot
  db_cluster_instance_class        = var.db_cluster_instance_class
  db_subnet_group_name             = var.db_cluster_subnet_name
  deletion_protection              = var.db_cluster_delete_protect
  storage_encrypted                = var.db_cluster_encryption
  kms_key_id                       = var.db_cluster_kms_arn
  skip_final_snapshot              = var.db_cluster_skip_final_snapshot
  final_snapshot_identifier        = var.db_cluster_final_snapshot_identifier
  backup_retention_period          = var.db_cluster_backup_retention_period
  preferred_backup_window          = var.db_cluster_preferred_backup_window
  preferred_maintenance_window     = var.db_cluster_preferred_maintenance_window
  allow_major_version_upgrade      = var.db_cluster_allow_major_version_upgrade
  vpc_security_group_ids           = var.db_cluster_security_groups
  enabled_cloudwatch_logs_exports  = var.db_cluster_enabled_cloudwatch_logs_exports
  db_cluster_parameter_group_name  = var.db_cluster_parameter_group_name
  db_instance_parameter_group_name = var.db_instance_parameter_group_name
  database_name                    = var.db_cluster_db_name
  master_username                  = var.db_cluster_master_username
  master_password                  = var.db_cluster_master_password

  dynamic "restore_to_point_in_time" {
    for_each = var.db_cluster_restore_to_point_in_time
    content {
      source_cluster_identifier  = lookup(restore_to_point_in_time, "source_cluster_identifier", null)
      restore_type               = lookup(restore_to_point_in_time, "restore_type", null)
      use_latest_restorable_time = lookup(restore_to_point_in_time, "use_latest_restorable_time", null)
    }
  }

  dynamic "serverlessv2_scaling_configuration" {
    for_each = var.db_cluster_serverlessv2_scaling_configuration == null ? [] : [var.db_cluster_serverlessv2_scaling_configuration]
    content {
      max_capacity = lookup(serverlessv2_scaling_configuration.value, "max_capacity", 16)
      min_capacity = lookup(serverlessv2_scaling_configuration.value, "min_capacity", 0.5)
    }
  }

  dynamic "scaling_configuration" {
    for_each = var.db_cluster_scaling_configuration
    content {
      auto_pause               = lookup(scaling_configuration.value, "auto_pause", null)
      max_capacity             = lookup(scaling_configuration.value, "max_capacity", null)
      min_capacity             = lookup(scaling_configuration.value, "min_capacity", null)
      seconds_until_auto_pause = lookup(scaling_configuration.value, "seconds_until_auto_pause", null)
      timeout_action           = lookup(scaling_configuration.value, "timeout_action", null)
    }
  }



  tags = merge({
    Team        = "Alps-DevOps"
    Environment = var.environment
    Owner       = "Trustonic"
    Terraform   = "true"
  }, var.tags)

  lifecycle {
    ignore_changes = [
      engine_version, master_password
    ]
  }
}
