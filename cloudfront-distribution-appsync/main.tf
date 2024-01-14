resource "aws_appsync_graphql_api" "appsync_graphql_api" {
  name = var.appsync_graphql_api_name

  authentication_type      = var.authentication_type
  user_pool_config         = var.authentication_type == "AMAZON_COGNITO_USER_POOLS" ? var.user_pool_config : null
  openid_connect_config    = var.authentication_type == "OPENID_CONNECT" ? var.openid_connect_config : null
  lambda_authorizer_config = var.authentication_type == "AWS_LAMBDA" ? var.lambda_authorizer_config : null

  dynamic "additional_authentication_provider" {
    for_each = var.additional_authentication_provider
    content {
      authentication_type      = lookup(additional_authentication_provider.value, "authentication_type")
      user_pool_config         = lookup(additional_authentication_provider.value, "authentication_type") == "AMAZON_COGNITO_USER_POOLS" ? lookup(additional_authentication_provider.value, "user_pool_config", null) : null
      openid_connect_config    = lookup(additional_authentication_provider.value, "authentication_type") == "OPENID_CONNECT" ? lookup(additional_authentication_provider.value, "openid_connect_config", null) : null
      lambda_authorizer_config = lookup(additional_authentication_provider.value, "authentication_type") == "AWS_LAMBDA" ? lookup(additional_authentication_provider.value, "lambda_authorizer_config", null) : null
    }
  }

  tags = merge({
    Team        = "Alps-DevOps"
    Name        = var.appsync_graphql_api_name
    Environment = var.environment
    Terraform   = "true"
    Owner       = "Trustonic"
  }, var.tags)

  log_config {
    count                    = var.log_config.enabled ? 1 : 0
    cloudwatch_logs_role_arn = var.log_config.cloudwatch_logs_role_arn
    field_log_level          = "ERROR"
  }
}

data "aws_acm_certificate" "certificate" {
  domain   = var.certificate_domain
  statuses = ["ISSUED"]
  provider = aws.certificates
}

resource "aws_appsync_domain_name" "appsync_domain_name" {
  domain_name     = var.domain_name
  certificate_arn = var.aws_acm_certificate.certificate
}

resource "aws_appsync_api_key" "example" {
  api_id  = aws_appsync_graphql_api.example.id
}
