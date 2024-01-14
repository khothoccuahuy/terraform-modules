output "arn" {
  value = aws_db_parameter_group.without_prefix.arn
}

output "name" {
  value = aws_db_parameter_group.without_prefix.name
}