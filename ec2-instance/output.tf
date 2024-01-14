output "ec2_instance_ip" {
  value = aws_instance.instance.private_ip
}

output "ec2_instance_id" {
  value = aws_instance.instance.id
}