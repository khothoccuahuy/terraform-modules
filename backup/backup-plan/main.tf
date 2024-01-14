resource "aws_backup_plan" "backup_plan" {
  name = var.name

  rule {
    rule_name         = var.rule_name
    target_vault_name = var.target_vault_name
    schedule          = var.schedule
    recovery_point_tags = var.recovery_point_tags

    dynamic "lifecycle" {
      for_each = var.lifecycle_rule
      content {
        cold_storage_after  = lookup(lifecycle.value, "cold_storage_after")
        delete_after   = lookup(lifecycle.value, "delete_after")
      }
    }

  }

}