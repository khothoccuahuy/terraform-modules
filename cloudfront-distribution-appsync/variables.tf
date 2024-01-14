variable "environment" {
  type = string
}

variable "appsync_graphql_api_name" {
  type = string
}

variable "authentication_type" {
  type = string
}

variable "user_pool_config" {
  type     = object()
  nullable = true
}

variable "openid_connect_config" {
  type     = object()
  nullable = true
}

variable "lambda_authorizer_config" {
  type     = object()
  nullable = true
}

variable "additional_authentication_provider" {
  type    = list(object())
  default = []
}

variable "log_config" {
  type = object({
    enabled                  = bool
    cloudwatch_logs_role_arn = string
  })
}

variable "wafv2_web_acl" {
  type = object({
    enabled = bool
    arn     = string
  })
}

variable "tags" {
  type    = map(string)
  default = {}
}
