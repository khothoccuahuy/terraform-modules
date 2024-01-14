################################################################################
# Repository (Public and Private)
################################################################################

output "repository_arn" {
  description = "Full ARN of the repository"
  value       = try(aws_ecr_repository.ecr_repository.arn, null)
}

output "repository_registry_id" {
  description = "The registry ID where the repository was created"
  value       = try(aws_ecr_repository.ecr_repository.registry_id, null)
}

output "repository_url" {
  description = "The URL of the repository"
  value       = try(aws_ecr_repository.ecr_repository.repository_url,  null)
}