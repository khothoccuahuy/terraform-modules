resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.vpc_id

  tags = merge({
    Team        = "Alps-DevOps"
    Environment = var.environment
    Name        = var.internet_gateway_name
    Terraform   = "true"
  }, var.tags)
}