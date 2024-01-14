variable "iam_role_arn" {
  type = string
}

variable "name" {
  type = string
}

variable "plan_id" {
  type = string
}

variable "selection_tag" {
  type = list(object({
    type = string
    key = string
    value = string
  })
  )
}