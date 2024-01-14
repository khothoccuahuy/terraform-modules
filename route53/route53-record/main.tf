resource "aws_route53_record" "a_endpoint" {
  count   = var.record_type == "A" && length(var.alias_configuration) == 0 ? 1 : 0
  name    = format("%s.%s", var.record_name, var.zone_name)
  type    = var.record_type
  records = var.record_target
  zone_id = var.zone_id
  ttl     = var.record_ttl
}

resource "aws_route53_record" "cname_endpoint" {
  count   = var.record_type == "CNAME" ? 1 : 0
  name    = format("%s.%s", var.record_name, var.zone_name)
  type    = var.record_type
  records = var.record_target
  zone_id = var.zone_id
  ttl     = var.record_ttl
}

resource "aws_route53_record" "txt_endpoint" {
  count   = var.record_type == "TXT" ? 1 : 0
  name    = format("%s.%s", var.record_name, var.zone_name)
  type    = var.record_type
  records = var.record_target
  zone_id = var.zone_id
  ttl     = var.record_ttl
}

resource "aws_route53_record" "alias_endpoint" {
  count   = var.record_type == "A" && length(var.alias_configuration) > 0 ? 1 : 0
  name    = format("%s.%s", var.record_name, var.zone_name)
  type    = var.record_type
  zone_id = var.zone_id

  dynamic "alias" {
    for_each = var.alias_configuration
    content {
      name                   = lookup(alias.value, "name", null)
      zone_id                = lookup(alias.value, "zone_id", null)
      evaluate_target_health = lookup(alias.value, "evaluate_target_health", null)
    }
  }
}
