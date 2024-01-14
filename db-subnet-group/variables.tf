variable "environment" {
  type        = string
  description = "Environment for deploy"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "db_subnet_name" {
  type        = string
  description = "Subnet group name"
}

variable "db_subnets" {
  type        = list(string)
  description = "List of subnets for subnet group"
}
