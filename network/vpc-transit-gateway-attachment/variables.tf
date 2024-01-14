variable "subnet_ids" {
  type = list(string)
}
variable "transit_gateway_id" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "environment" {
  type = string
}
variable "name" {
  type = string
}
variable "tags" {
  description = "A list of tags for zone"
  type        = map(string)
  default     = {}
}