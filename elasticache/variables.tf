variable "elasticache_cluster_id" {
  type = string
}
variable "environment" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "elasticache_engine" {
  type = string
}
variable "elasticache_node_type" {
  type = string
}
variable "elasticache_node_number" {
  type = number
}
variable "elasticache_parameter_group" {
  type = string
}
variable "elasticache_engine_version" {
  type = string
}
variable "elasticache_port" {
  type = number
}
variable "elasticache_apply_immediately" {
  type = bool
}
variable "elasticache_sg_ids" {
  type    = list(string)
  default = []
}
variable "elasticache_subnet_group" {
  type = string
}
