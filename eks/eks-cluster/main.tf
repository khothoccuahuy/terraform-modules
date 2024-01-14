resource "aws_eks_cluster" "eks" {
  name     = var.eks_cluster_name
  role_arn = var.eks_cluster_iam_role_arn
  vpc_config {
    security_group_ids      = var.eks_cluster_security_groups
    subnet_ids              = var.eks_cluster_subnets
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
  }
# logs from control plane to cloudwatch is disabled
#  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  version                   = var.eks_cluster_version
  dynamic "encryption_config" {
    for_each = toset(var.cluster_encryption_config)

    content {
      provider {
        key_arn = encryption_config.value["provider_key_arn"]
      }
      resources = encryption_config.value["resources"]
    }
  }
  tags = {
    Team        = "Alps-DevOps"
    Name        = var.cluster_name
    Environment = var.environment
    Terraform   = "true"
  }
}

resource "aws_iam_openid_connect_provider" "eks_oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.external.thumbprint.result.thumbprint, data.external.thumbprint.result.last_thumbprint]
  url             = aws_eks_cluster.eks.identity.0.oidc.0.issuer
}

data "external" "thumbprint" {
  program = ["bash", "files/scripts/eksthumbprint.sh", var.region]
}

