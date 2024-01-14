variable "vpc" {
  type    = bool
  default = true
}
variable "environment" {
  type = string
}
variable "elastic_ip_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
