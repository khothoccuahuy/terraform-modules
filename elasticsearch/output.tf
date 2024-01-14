output "elasticsearch_url" {
  description = "Elasticsearch Url"
  value       = aws_elasticsearch_domain.elasticsearch.endpoint
}