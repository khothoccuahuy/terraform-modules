resource "aws_ssm_parameter" "parameter" {
  name  = var.name
  type  = var.type
  value = var.value
  description = var.description
//  tags  = var.tags
  tags = merge(
  {},
  var.tags
  )

  lifecycle {
    ignore_changes = [
      value,
      tags
    ]
  }
}