resource "aws_glue_crawler" "crawler" {
  database_name = var.database_name
  name          = var.name
  role          = var.iam_role

  schema_change_policy {
    delete_behavior = "LOG"
    update_behavior = "LOG"
  }

  recrawl_policy {
    recrawl_behavior = var.recrawl_behavior
  }

  dynamic "s3_target" {
    for_each = var.s3_target
    content {
      path            = s3_target.value.path
      exclusions      = s3_target.value.exclusions
      connection_name = s3_target.value.connection_name
    }
  }

  tags = merge({
    Team        = "Alps-DevOps"
    Name        = var.name
    Environment = var.environment
  }, var.tags)
}
