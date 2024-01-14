output "arn" {
  value       = aws_efs_file_system.efs.arn
  description = "EFS ARN"
}

output "id" {
  value       = aws_efs_file_system.efs.id
  description = "EFS ID"
}

output "dns_name" {
  value       = aws_efs_file_system.efs.dns_name
  description = "EFS DNS name"
}

output "mount_target_ids" {
  value       = coalescelist(aws_efs_mount_target.target.*.id, [""])
  description = "List of EFS mount target IDs (one per Availability Zone)"
}
