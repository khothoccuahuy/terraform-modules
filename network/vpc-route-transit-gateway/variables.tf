variable "route_table_id" {
  type = string
}

variable "destination_cidr_block" {
  type = string
}

variable "transit_gateway_id" {
  type = string
  default = null
}