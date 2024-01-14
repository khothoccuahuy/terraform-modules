variable "environment" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "appsync_graphql_api_name" {
  type = string
}

variable "authentication_type" {
  type = string
}

variable "user_pool_config" {
  type = object({
    default_action      = string
    user_pool_id        = string
    app_id_client_regex = string
    aws_region          = string
  })
  nullable = true
}

variable "openid_connect_config" {
  type = object({
    issuer    = string
    auth_ttl  = number
    client_id = string
    iat_ttl   = number
  })
  nullable = true
}

variable "lambda_authorizer_config" {
  type = object({
    authorizer_uri                   = string
    authorizer_result_ttl_in_seconds = number
    identity_validation_expression   = string
  })
  nullable = true
}

variable "additional_authentication_provider" {
  type = list(object({
    authentication_type = string
    user_pool_config = object({
      user_pool_id        = string
      app_id_client_regex = string
      aws_region          = string
    })
    openid_connect_config = object({
      issuer    = string
      auth_ttl  = number
      client_id = string
      iat_ttl   = number
    })
    lambda_authorizer_config = object({
      authorizer_uri                   = string
      authorizer_result_ttl_in_seconds = number
      identity_validation_expression   = string
    })
  }))
  default = []
}

variable "log_config" {
  type = object({
    enabled                  = bool
    cloudwatch_logs_role_arn = string
  })
}

variable "api_key_expires" {
  type    = string
  default = "168h"
}

variable "appsync_domain" {
  type = object({
    enable      = bool
    domain_name = string
    certificate = string
  })
}
