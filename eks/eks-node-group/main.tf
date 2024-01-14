resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = var.eks_cluster_name
  node_group_name = "${var.eks_node_group_name}-${random_id.random.b64_url}"
  node_role_arn   = var.eks_node_group_iam_role_arn
  subnet_ids      = var.eks_node_group_subnet_list

  disk_size = var.eks_node_group_disk_size
  ami_type  = var.eks_node_group_ami_type

  scaling_config {
    desired_size = var.eks_node_group_desired_size
    min_size     = var.eks_node_group_min_size
    max_size     = var.eks_node_group_max_size
  }

  instance_types = var.eks_node_group_instance_types

  capacity_type  = var.eks_node_group_capacity_type

  labels = {
    cluster_name    = var.eks_cluster_name
    node_group_name = var.eks_node_group_name
    az              = var.eks_node_group_label_az
    lifecycle       = var.eks_node_group_label_lifecycle
    node_pool       = var.eks_node_group_label_pool
  }

  remote_access {
    ec2_ssh_key               = var.eks_node_group_ssh_key_name
    source_security_group_ids = [var.eks_node_group_source_security_group_id]
  }

  # by default is latest ami id
  release_version = var.eks_node_group_ami_release_version

  tags = {
    Team        = "Alps-DevOps"
    Name        = var.eks_node_group_name
    Environment = var.environment
    Managed-by  = "Terraform"
    Owner       = var.owner
  }

  tags_all = {
    Name        = var.eks_node_group_name
    Environment = var.environment
    Managed-by  = "Terraform"
    Owner       = var.owner
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [
      scaling_config[0].desired_size,
      instance_types
    ]
  }

}

resource "random_id" "random" {
  byte_length = 5
  keepers = {
      eks_node_group_instance_types = jsonencode(var.eks_node_group_instance_types),
      eks_node_group_ami_type = var.eks_node_group_ami_type,
      eks_node_group_ami_release_version = var.eks_node_group_ami_release_version,
      eks_node_group_disk_size = var.eks_node_group_disk_size,
      eks_node_group_subnet_list = var.eks_node_group_subnet_list.0
  }
}