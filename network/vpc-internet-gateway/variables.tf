variable "vpc_id" {
  type = string
}
variable "environment" {
  type = string
}
variable "internet_gateway_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
