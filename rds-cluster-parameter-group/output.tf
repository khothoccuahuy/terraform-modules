output "arn" {
  value = aws_rds_cluster_parameter_group.without_prefix.arn
}

output "name" {
  value = aws_rds_cluster_parameter_group.without_prefix.id
}