variable "name" {
  type = string
}

variable "type" {
  type = string
  default = "SecureString"
}

variable "value" {
  type = string
  default = "Please-set-variable"
}

variable "tags" {
  type = any
}

variable "description" {
  type = string
}