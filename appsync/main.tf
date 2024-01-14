resource "aws_appsync_graphql_api" "appsync_graphql_api" {
  name = var.appsync_graphql_api_name

  authentication_type = var.authentication_type
  dynamic "user_pool_config" {
    for_each = var.authentication_type == "AMAZON_COGNITO_USER_POOLS" ? [var.user_pool_config] : []
    content {
      default_action      = user_pool_config.value.default_action
      user_pool_id        = user_pool_config.value.user_pool_id
      app_id_client_regex = user_pool_config.value.app_id_client_regex
      aws_region          = user_pool_config.value.aws_region
    }
  }
  dynamic "openid_connect_config" {
    for_each = var.authentication_type == "OPENID_CONNECT" ? [var.openid_connect_config] : []
    content {
      issuer    = openid_connect_config.value.issuer
      auth_ttl  = openid_connect_config.value.auth_ttl
      client_id = openid_connect_config.value.client_id
      iat_ttl   = openid_connect_config.value.iat_ttl
    }
  }
  dynamic "lambda_authorizer_config" {
    for_each = var.authentication_type == "AWS_LAMBDA" ? [var.lambda_authorizer_config] : []
    content {
      authorizer_uri                   = lambda_authorizer_config.value.authorizer_uri
      authorizer_result_ttl_in_seconds = lambda_authorizer_config.value.authorizer_result_ttl_in_seconds
      identity_validation_expression   = lambda_authorizer_config.value.identity_validation_expression
    }
  }

  dynamic "additional_authentication_provider" {
    for_each = var.additional_authentication_provider
    content {
      authentication_type = additional_authentication_provider.value.authentication_type
      dynamic "user_pool_config" {
        for_each = additional_authentication_provider.value.authentication_type == "AMAZON_COGNITO_USER_POOLS" ? [additional_authentication_provider.value.user_pool_config] : []
        content {
          user_pool_id        = user_pool_config.value.user_pool_id
          app_id_client_regex = user_pool_config.value.app_id_client_regex
          aws_region          = user_pool_config.value.aws_region
        }
      }
      dynamic "openid_connect_config" {
        for_each = additional_authentication_provider.value.authentication_type == "OPENID_CONNECT" ? [additional_authentication_provider.value.openid_connect_config] : []
        content {
          issuer    = openid_connect_config.value.issuer
          auth_ttl  = openid_connect_config.value.auth_ttl
          client_id = openid_connect_config.value.client_id
          iat_ttl   = openid_connect_config.value.iat_ttl
        }
      }
      dynamic "lambda_authorizer_config" {
        for_each = additional_authentication_provider.value.authentication_type == "AWS_LAMBDA" ? [additional_authentication_provider.value.lambda_authorizer_config] : []
        content {
          authorizer_uri                   = lambda_authorizer_config.value.authorizer_uri
          authorizer_result_ttl_in_seconds = lambda_authorizer_config.value.authorizer_result_ttl_in_seconds
          identity_validation_expression   = lambda_authorizer_config.value.identity_validation_expression
        }
      }
    }
  }

  tags = merge({
    Team        = "Alps-DevOps"
    Name        = var.appsync_graphql_api_name
    Environment = var.environment
    Terraform   = "true"
    Owner       = "Trustonic"
  }, var.tags)

  dynamic "log_config" {
    for_each = var.log_config.enabled ? [var.log_config] : []
    content {
      cloudwatch_logs_role_arn = log_config.value.cloudwatch_logs_role_arn
      field_log_level          = "ERROR"
    }
  }

  lifecycle {
    ignore_changes = [
      name,
      authentication_type,
      user_pool_config,
      openid_connect_config,
      lambda_authorizer_config,
      schema,
      additional_authentication_provider
    ]
    prevent_destroy = true
  }
}

resource "aws_appsync_api_key" "appsync_api_key" {
  api_id  = aws_appsync_graphql_api.appsync_graphql_api.id
  expires = timeadd(timestamp(), var.api_key_expires)
}

resource "aws_appsync_domain_name" "appsync_domain_name" {
  count           = var.appsync_domain.enable ? 1 : 0
  domain_name     = var.appsync_domain.domain_name
  certificate_arn = var.appsync_domain.certificate
}

resource "aws_appsync_domain_name_api_association" "appsync_domain_name_api_association" {
  count       = length(aws_appsync_domain_name.appsync_domain_name)
  api_id      = aws_appsync_graphql_api.appsync_graphql_api.id
  domain_name = aws_appsync_domain_name.appsync_domain_name[count.index].domain_name
}
