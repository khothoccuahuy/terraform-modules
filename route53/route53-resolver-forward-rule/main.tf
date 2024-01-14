resource "aws_route53_resolver_rule" "forward_resolver_rule" {
  domain_name          = var.domain_name
  name                 = var.name
  rule_type            = "FORWARD"
  resolver_endpoint_id = var.resolver_endpoint_id

  dynamic "target_ip" {
    for_each = var.target_ip

    content {
      ip =  target_ip.value.ip_address
    }
  }

  tags = merge(
  {
    Environment = var.environment
    Terraform   = "true"
    Name        = var.name
  },
  var.tags
  )
}