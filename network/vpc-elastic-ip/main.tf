resource "aws_eip" "elastic_ip" {
  domain = var.vpc ? "vpc" : null

  tags = merge({
    Team        = "Alps-DevOps"
    Environment = var.environment
    Name        = var.elastic_ip_name
    Terraform   = "true"
  }, var.tags)
}
