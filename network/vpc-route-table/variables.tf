variable "vpc_id" {
  type = string
}
variable "environment" {
  type = string
}
variable "route_table_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
