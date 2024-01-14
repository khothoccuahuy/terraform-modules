output "appsync_domain_name" {
  value = aws_appsync_domain_name.appsync_domain_name[0].appsync_domain_name
}

output "appsync_hosted_zone_id" {
  value = aws_appsync_domain_name.appsync_domain_name[0].hosted_zone_id
}