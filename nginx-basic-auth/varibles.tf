variable "ssm_prefix" {
  type = string
}

variable "service_name" {
  type = string
}

variable "apps_shared_namespace" {
  type = string
  default = "apps-shared"
}

variable "tags" {
  type = any
}