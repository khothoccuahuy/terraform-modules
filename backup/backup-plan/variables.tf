variable "name" {
  type = string
}

variable "rule_name" {
  type = string
}

variable "target_vault_name" {
  type = string
}

variable "schedule" {
  type = string
}

variable "recovery_point_tags" {
  type = map(string)
}

variable "lifecycle_rule" {
  type = list(object({
    cold_storage_after = number
    delete_after = number
  })
  )
}