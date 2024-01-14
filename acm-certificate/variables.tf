variable "route53_zone_id" {
  type = string
}

variable "dns_name" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}