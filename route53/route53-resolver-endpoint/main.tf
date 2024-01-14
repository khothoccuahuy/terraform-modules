resource "aws_route53_resolver_endpoint" "resolver_endpoint" {
  name      = var.name
  direction = var.direction

  security_group_ids = var.security_group_ids

  dynamic "ip_address" {
    for_each = var.ip_addresses

    content {
      ip        = lookup(ip_address.value, "ip", null)
      subnet_id = ip_address.value.subnet_id
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