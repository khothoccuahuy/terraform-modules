variable "elasticache_subnet_group_name" {
  type = string
}

variable "elasticache_subnet_group_subnet_ids" {
  type    = list(string)
  default = []
}

variable "elasticache_subnet_group_description" {
  type    = string
  default = "Managed by Terraform"
}