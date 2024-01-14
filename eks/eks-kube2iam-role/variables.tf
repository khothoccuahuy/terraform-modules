variable "node_iam_role_arn" {
  type = string
}

variable "iam_role_policy_document_json" {
  type    = string
  default = ""
}

variable "role_name" {
  type = string
}
