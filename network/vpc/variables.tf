variable "vpc_cidr_block" {
  type = string
}
variable "vpc_enable_dns_support" {
  type = bool
}
variable "vpc_enable_dns_hostnames" {
  type = bool
}
variable "vpc_instance_tenancy" {
  type = string
}
variable "environment" {
  type = string
}
variable "vpc_name" {
  type = string
}
variable "tags" {
  description = "Map of tags to apply on the resources"
  type        = map(string)
  default     = {}
}
