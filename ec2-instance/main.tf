resource "aws_instance" "instance" {
  ami                                  = var.ami_id
  instance_type                        = var.instance_type
  user_data                            = var.userdata
  ebs_optimized                        = var.ebs_optimized
  instance_initiated_shutdown_behavior = "stop"
  disable_api_termination              = var.disable_api_termination
  hibernation                          = var.hibernation
  key_name                             = var.key_name
  monitoring                           = var.monitoring
  iam_instance_profile                 = var.iam_instance_profile
  vpc_security_group_ids               = var.security_groups
  subnet_id                            = var.subnet_id

  dynamic "root_block_device" {
    for_each = var.root_block_device
    content {
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
      encrypted             = lookup(root_block_device.value, "encrypted", null)
      iops                  = lookup(root_block_device.value, "iops", null)
      kms_key_id            = lookup(root_block_device.value, "kms_key_id", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      throughput            = lookup(root_block_device.value, "throughput", null)
      tags = {
        Team        = "Alps-DevOps"
        Managed-by  = "Terraform"
        Name        = var.instance_name
        Environment = var.environment
        Snapshot    = var.snapshot_tag
      }
    }
  }
  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
      device_name           = ebs_block_device.value.device_name
      encrypted             = lookup(ebs_block_device.value, "encrypted", null)
      iops                  = lookup(ebs_block_device.value, "iops", null)
      kms_key_id            = lookup(ebs_block_device.value, "kms_key_id", null)
      snapshot_id           = lookup(ebs_block_device.value, "snapshot_id", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
      throughput            = lookup(ebs_block_device.value, "throughput", null)
    }
  }
  tags = merge({
    Team        = "Alps-DevOps"
    Managed-by  = "Terraform"
    Environment = var.environment
    Name        = var.instance_name
    Snapshot    = var.snapshot_tag
    Owner       = "Trustonic"
  }, var.tags)
}
