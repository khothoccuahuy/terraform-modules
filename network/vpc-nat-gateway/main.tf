resource "aws_nat_gateway" "nat_gateway" {
  subnet_id     = var.subnet_id
  allocation_id = var.allocation_id

  tags = merge({
    Team        = "Alps-DevOps"
    Environment = var.environment
    Name        = var.nat_gateway_name
    Terraform   = "true"
  }, var.tags)
}