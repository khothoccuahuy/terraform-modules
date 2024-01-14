variable "eks_cluster_name" {
  type = string
}

variable "eks_cluster_version" {
  type = string
}

variable "eks_cluster_subnets" {
  type = list(string)
}

variable "eks_cluster_security_groups" {
  type    = list(string)
  default = null
}

variable "environment" {
  type = string
}

variable "region" {
  type = string
}
variable "eks_cluster_iam_role_arn" {
  type = string
}
variable "cluster_name" {
  type = string
}
variable "endpoint_private_access" {
  type = bool
}
variable "endpoint_public_access" {
  type = bool
}

variable "cluster_encryption_config" {
  type = list(object({
    provider_key_arn = string
    resources        = list(string)
  }))
  description = "Configuration block with encryption configuration for the cluster."
  default = []
}