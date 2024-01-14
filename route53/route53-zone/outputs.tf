output "route53_zone_id" {
  description = "Route53 zone id"
  value       = aws_route53_zone.route53_zone.id
}

output "route53_name_servers" {
  description = "Nameservers for this zone"
  value       = aws_route53_zone.route53_zone.name_servers
}
