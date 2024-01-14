variable "name" {
  description = "sns topic name"
}

variable "create_topic_policy" {
  type    = bool
  default = false
}

variable "topic_policy" {
  type    = any
  default = {}
}

variable "environment" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
