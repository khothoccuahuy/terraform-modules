variable "security_group_name" {
  type = string
}

variable "security_group_revoke_rules_on_delete" {
  type = bool
}

variable "vpc_id" {
  type = string
}

variable "security_group_description" {
  type = string
}

variable "security_group_egress_rules" {
  type    = any
  default = []
}

variable "security_group_ingress_rules" {
  type    = any
  default = []
}

variable "environment" {
  type = string
}

variable "owner" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
