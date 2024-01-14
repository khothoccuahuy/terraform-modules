variable "vpc_id" {
  type = string
}

variable "eks_name" {
  type = string
}

variable "eks_node_security_groups" {
  type = list(string)
}

variable "eks_version" {
  type = string
}

variable "eks_endpoint" {
  type = string
}

variable "eks_certificate_authority" {
  type = string
}

variable "eks_node_instance_type" {
  type = string
}

variable "eks_node_instance_key_name" {
  type = string
}

variable "eks_node_name" {
  type = string
}

variable "eks_node_vpc_zone_identifier" {
  type = string
}

variable "environment" {
  type = string
}

variable "eks_node_instance_profile_name" {
  type = string
}

variable "eks_asg_desired_capacity" {
  type    = number
  default = 1
}

variable "eks_asg_min_size" {
  type    = number
  default = 1
}

variable "eks_asg_max_size" {
  type    = number
  default = 5
}

variable "image_id" {
  type = string
}