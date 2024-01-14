variable "ami_id" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "environment" {
  type = string
}
variable "ebs_optimized" {
  type = bool
}
variable "disable_api_termination" {
  type = bool
}
variable "hibernation" {
  type = bool
}
variable "key_name" {
  type = string
}
variable "monitoring" {
  type = bool
}
variable "instance_name" {
  type = string
}
variable "security_groups" {
  type = list(string)
}
variable "userdata" {
  type    = string
  default = null
}
variable "iam_instance_profile" {
  type    = string
  default = null
}
variable "subnet_id" {
  type = string
}
variable "snapshot_tag" {
  type = string
}
variable "root_block_device" {
  description = "Customize details about the root block device of the instance. See Block Devices below for details"
  type        = list(any)
  default     = []
}
variable "ebs_block_device" {
  type    = list(any)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
