resource "aws_backup_selection" "backup_selection" {
  iam_role_arn = var.iam_role_arn
  name         = var.name
  plan_id      = var.plan_id

  dynamic "selection_tag" {
    for_each = var.selection_tag
    content {
      type  = lookup(selection_tag.value, "type")
      key   = lookup(selection_tag.value, "key")
      value = lookup(selection_tag.value, "value")
    }
  }

}