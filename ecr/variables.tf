variable "ecr_name" {
  type = string
}
variable "ecr_image_tag_mutability" {
  type    = string
  default = "MUTABLE"
}
variable "ecr_scan_on_push" {
  type    = bool
  default = true
}
//variable "environment" {
//  type = string
//}
//
//variable "owner" {
//  type = string
//}

variable "ecr_lifecycle_policy_description" {
  type    = string
  default = "Only one untagged image will be in repo."
}

variable "ecr_lifecycle_policy_count_number" {
  type    = number
  default = 1
}

variable "tags" {
  type = any
}