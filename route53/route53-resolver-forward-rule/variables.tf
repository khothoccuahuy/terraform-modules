variable "domain_name" {
  type = string
}

variable "name" {
  type = string
}

variable "resolver_endpoint_id" {
  type = string
}

variable "target_ip" {
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