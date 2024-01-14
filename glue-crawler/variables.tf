variable "database_name" {
  type = string
}
variable "name" {
  type = string
}
variable "iam_role" {
  type = string
}
variable "s3_target" {
  type = list(object({
    path = string
    exclusions = list(string)
    connection_name = string
  }))
  default = []
}
variable "environment" {
  type = string
}
variable "recrawl_behavior" {
  type = string
  default = "CRAWL_NEW_FOLDERS_ONLY" 
}

variable "tags" {
  type    = map(string)
  default = {}
}
