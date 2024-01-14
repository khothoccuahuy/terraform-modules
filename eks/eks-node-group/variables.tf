variable "eks_cluster_name" {
  type = string
}

variable "eks_node_group_name" {
  type = string
}

variable "eks_node_group_iam_role_arn" {
  type = string
}

variable "eks_node_group_subnet_list" {
  type = list(string)
}

variable "eks_node_group_desired_size" {
  type = number
}

variable "eks_node_group_min_size" {
  type = number
}

variable "eks_node_group_max_size" {
  type = number
}

variable "eks_node_group_label_az" {
  type = string
}

variable "eks_node_group_label_lifecycle" {
  type    = string
  default = "OnDemand"
}

variable "eks_node_group_capacity_type" {
  type    = string
  default = "ON_DEMAND"
}

variable "eks_node_group_label_pool" {
  type    = string
}

variable "eks_node_group_instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}

variable "eks_node_group_ssh_key_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "owner" {
  type = string
}

# be default is used latest AMI ID release
variable "eks_node_group_ami_release_version" {
  type = string
}

variable "eks_node_group_source_security_group_id" {
  type = string
}

variable "eks_node_group_disk_size" {
  type    = number
  default = 20
}

variable "eks_node_group_ami_type" {
  type    = string
  default = "AL2_x86_64"
}