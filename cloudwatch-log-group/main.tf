resource "aws_cloudwatch_log_group" "aws_cloudwatch_log_group" {
  name              = var.cloudwatch_log_group_name
  retention_in_days = var.cloudwatch_log_group_retention_in_days
  tags = merge({
    Team        = "Alps-DevOps"
    Name        = var.cloudwatch_log_group_name
    Environment = var.environment
    Terraform   = "true"
    Owner       = var.owner
  }, var.tags)
}