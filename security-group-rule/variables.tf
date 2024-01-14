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
    description = string
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
    description              = string
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

variable "security_group_id" {}

variable "source_security_group_id" {
}