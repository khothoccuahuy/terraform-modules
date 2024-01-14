variable "name" {
  type = string
}

variable "direction" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "ip_addresses" {
  description = "Specify subnets and IP addresses to use for your endpoints. subnet_id is mandatory, ip is optional"
  type        = list(map(any))

  # syntax:
  # object({
  #    subnet_id = string
  #    ip        = string
  #  }
}

variable "tags" {
  description = "A list of tags for zone"
  type        = map(string)
  default     = {}
}

variable "environment" {
  type = string
}