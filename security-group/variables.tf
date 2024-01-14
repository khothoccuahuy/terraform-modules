variable "environment" {
  type = string
}

variable "owner" {
  type = string
}

variable "security_group_name" {
  type = string
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "security_group_description" {
  type    = string
  default = "Default Security Group"
}

variable "ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where 'cidr_blocks' is used"
  type        = list(map(string))
  default     = []
}

variable "ingress_cidr_blocks_map_list" {
  description = "Can be specified multiple times for each ingress rule. "
  type = list(object({
    from_port   = number
    protocol    = string
    to_port     = number
    cidr_blocks = list(string)
  }))
  default = []
}

variable "ingress_sg_map_list" {
  description = "Can be specified multiple times for each ingress rule. "
  type = list(object({
    from_port                = number
    protocol                 = string
    to_port                  = number
    source_security_group_id = string
  }))
  default = []
}

variable "ingress_self_sg_map_list" {
  description = "Can be specified multiple times for each ingress rule. "
  type = list(object({
    from_port = number
    protocol  = string
    to_port   = number
  }))
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
