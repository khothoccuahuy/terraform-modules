output "eks_version" {
  value = aws_eks_cluster.eks.version
}

output "eks_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "eks_certificate_authority" {
  value = aws_eks_cluster.eks.certificate_authority.0.data
}

output "eks_name" {
  value = aws_eks_cluster.eks.name
}

output "aws_iam_openid_connect_provider_url" {
  value = aws_iam_openid_connect_provider.eks_oidc.url
}

output "aws_iam_openid_connect_provider_arn" {
  value = aws_iam_openid_connect_provider.eks_oidc.arn
}

output "eks_cluster_sg_id" {
  value = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
}