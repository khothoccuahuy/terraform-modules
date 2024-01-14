output "node_endpoint" {
  value = aws_elasticache_cluster.elastis_cache.cache_nodes.0.address
}