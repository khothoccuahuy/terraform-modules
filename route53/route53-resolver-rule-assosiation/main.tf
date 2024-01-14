resource "aws_route53_resolver_rule_association" "resolver_rule_association" {
  resolver_rule_id = var.resolver_rule_id
  vpc_id           = var.vpc_id
  name             = var.name
}