resource "aws_security_group" "security_group" {
  name                   = var.security_group_name
  revoke_rules_on_delete = var.security_group_revoke_rules_on_delete
  vpc_id                 = var.vpc_id
  description            = var.security_group_description
  egress                 = var.security_group_egress_rules
  ingress                = var.security_group_ingress_rules
  tags = merge({
    "Environment" = var.environment
    "Name"        = var.security_group_name
    "Managed-by"  = "Terraform"
    "Owner"       = var.owner
  }, var.tags)
}
