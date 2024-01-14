output "vpc_endpoint_id_dynamo_db" {
  value = aws_vpc_endpoint.dynamo[0].id
}