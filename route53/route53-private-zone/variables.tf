variable "route53_zone_domain_name" {
  type        = string
  description = "Domain name"
}

variable "vpc_id" {
  type = string
}

variable "environment" {
  type = string
}

variable "tags" {
  description = "A list of tags for zone"
  type        = map(string)
  default     = {}
}