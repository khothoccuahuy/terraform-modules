variable "environment" {
  type = string
}

variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "account_id" {
  type = string
}

variable "table_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
