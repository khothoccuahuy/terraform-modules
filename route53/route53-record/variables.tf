variable "record_name" {
  type = string
}
variable "zone_name" {
  type = string
}
variable "record_type" {
  type = string
}
variable "record_ttl" {
  type    = string
  default = 60
}
variable "zone_id" {
  type = string
}
//
//variable "route53_records_map" {
//  type = map(string)
//  default = {
//  }
//}

variable "record_target" {
  type    = list(string)
  default = []
}

variable "alias_configuration" {
  type = list(object({
    name                   = string
    zone_id                = string
    evaluate_target_health = bool
  }))
  default     = []
  description = "Object with alias parameters"
}
