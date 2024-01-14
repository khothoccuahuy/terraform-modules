variable "name" {
  description = "The name of the DB parameter group"
  type        = string
  default     = ""
}
variable "description" {
  description = "The description of the DB parameter group"
  type        = string
  default     = ""
}
variable "family" {
  description = "The family of the DB parameter group"
  type        = string
}
variable "parameters" {
  description = "A list of DB parameter maps to apply"
  type        = list(map(string))
  default     = []
}
variable "environment" {
  type = string
}