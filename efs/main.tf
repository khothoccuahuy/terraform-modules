resource "aws_efs_file_system" "efs" {
  encrypted                       = var.efs_encrypted
  kms_key_id                      = var.efs_kms_key_id
  performance_mode                = var.efs_performance_mode
  provisioned_throughput_in_mibps = var.efs_provisioned_throughput_in_mibps
  throughput_mode                 = var.efs_throughput_mode


  dynamic "lifecycle_policy" {
    for_each = var.efs_transition_to_ia == "" ? [] : [1]
    content {
      transition_to_ia = var.efs_transition_to_ia
    }
  }

  tags = merge({
    Team        = "Alps-DevOps"
    Name        = var.efs_name
    Environment = var.environment
    Terraform   = "true"
    Owner       = var.owner
  }, var.tags)

}

resource "aws_efs_mount_target" "target" {
  count           = length(var.subnet_ids) > 0 ? length(var.subnet_ids) : 0
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.subnet_ids[count.index]
  security_groups = ["${var.efs_security_group_id}"]
}
