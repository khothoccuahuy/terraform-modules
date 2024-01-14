resource "aws_rds_cluster_parameter_group" "without_prefix" {
  name        = var.name
  description = var.description
  family      = var.family

  dynamic "parameter" {
    for_each = var.parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = lookup(parameter.value, "apply_method", null)
    }
  }

  tags = merge({
    Team        = "Alps-DevOps"
    Environment = var.environment
    Terraform   = "true"
    Name        = var.name
  }, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}