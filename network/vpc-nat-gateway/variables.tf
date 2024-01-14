variable "subnet_id" {
  type = string
}
variable "allocation_id" {
  type = string
}
variable "environment" {
  type = string
}
variable "nat_gateway_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
