variable "route53_zone_reference_name" {
  description = "Reference name"
  default = null
}

variable "route53_zone_domain_name" {
  type        = string
  description = "Domain name"
}

variable "environment" {
  type = string
}

variable "tags" {
  description = "A list of tags for zone"
  type        = map(string)
  default     = {}
}

