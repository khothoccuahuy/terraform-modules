resource "aws_db_subnet_group" "db_subnet_group" {
  name       = var.db_subnet_name
  subnet_ids = var.db_subnets

  tags = merge({
    Team        = "Alps-DevOps"
    Terraform   = "true"
    Environment = var.environment
    Name        = var.db_subnet_name
    Owner       = "Trustonic"
  }, var.tags)
}
