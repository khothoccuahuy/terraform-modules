resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id

  tags = merge({
    Team        = "Alps-DevOps"
    Environment = var.environment
    Name        = var.route_table_name
    Terraform   = "true"
  }, var.tags)
}