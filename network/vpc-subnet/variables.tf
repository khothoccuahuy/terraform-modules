variable "vpc_id" {
  type = string
}
variable "subnet_cird_block" {
  type = string
}
variable "subnet_availability_zone" {
  type = string
}
variable "environment" {
  type = string
}
variable "subnet_name" {
  type = string
}

variable "tags" {
  description = "Map of tags to apply on the resources"
  type        = map(string)
  default     = {}
}