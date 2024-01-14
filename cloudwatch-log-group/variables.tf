variable "environment" {
  type        = string
  description = "Environment for deploy"
}

variable "cloudwatch_log_group_name" {
  type = string
}

variable "owner" {
  type = string
}

variable "cloudwatch_log_group_retention_in_days" {
  type    = number
  default = 14
}

variable "tags" {
  type    = map(string)
  default = {}
}
