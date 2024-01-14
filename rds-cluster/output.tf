output "address" {
  value = aws_rds_cluster.this.endpoint
}

output "identifier" {
  value = aws_rds_cluster.this.cluster_identifier
}

output "port" {
  value = aws_rds_cluster.this.port
}

output "master_username" {
  value = aws_rds_cluster.this.master_username
}

output "db_name" {
  value = aws_rds_cluster.this.database_name
}

output "hosted_zone_id" {
  value = aws_rds_cluster.this.hosted_zone_id
}

output "cluster_members" {
  value = aws_rds_cluster.this.cluster_members
}

output "engine" {
  value = aws_rds_cluster.this.engine
}