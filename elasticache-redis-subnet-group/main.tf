resource "aws_elasticache_subnet_group" "subnet_group" {
  name        = var.elasticache_subnet_group_name
  subnet_ids  = var.elasticache_subnet_group_subnet_ids
  description = var.elasticache_subnet_group_description
}
