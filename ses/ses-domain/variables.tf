variable "domain_name" {
  type = string
}

variable "route53_zone_id" {
  type = string
}

variable "route53_ttl" {
  type = string
  default = "60"
}