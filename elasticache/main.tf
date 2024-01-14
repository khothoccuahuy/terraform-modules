resource "aws_elasticache_cluster" "elastis_cache" {
  cluster_id           = var.elasticache_cluster_id
  engine               = var.elasticache_engine
  node_type            = var.elasticache_node_type
  num_cache_nodes      = var.elasticache_node_number
  parameter_group_name = var.elasticache_parameter_group
  engine_version       = var.elasticache_engine_version
  port                 = var.elasticache_port
  apply_immediately    = var.elasticache_apply_immediately
  security_group_ids   = var.elasticache_sg_ids
  subnet_group_name    = var.elasticache_subnet_group
  tags = merge({
    Name        = var.elasticache_cluster_id
    Environment = var.environment
    Managed-by  = "Terraform"
    Owner       = "Trustonic"
  }, var.tags)
}
