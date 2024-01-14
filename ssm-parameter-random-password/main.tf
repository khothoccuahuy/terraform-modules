resource "aws_ssm_parameter" "parameter" {
  name  = var.name
  type  = var.type
  value = random_password.random_pass.result
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

resource "random_password" "random_pass" {
  length      = 15
  special     = true
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
}