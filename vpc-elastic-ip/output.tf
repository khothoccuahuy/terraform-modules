output "elastic_ip_id" {
  value = aws_eip.elastic_ip.id
}

output "elastic_public_ip" {
  value = aws_eip.elastic_ip.public_ip
}