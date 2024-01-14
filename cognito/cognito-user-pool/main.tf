resource "aws_cognito_user_pool" "userpool" {
  name = var.cognito_user_pool_name

  alias_attributes = var.cognito_user_pool_alias_attributes

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_uppercase = true
    require_numbers   = true
    require_symbols   = true
  }

  auto_verified_attributes   = var.auto_verified_attributes
  mfa_configuration          = var.mfa_configuration
  email_verification_message = var.email_verification_message
  email_verification_subject = var.email_verification_subject
  sms_authentication_message = var.sms_authentication_message
  sms_verification_message   = var.sms_verification_message

  device_configuration {
    challenge_required_on_new_device      = true
    device_only_remembered_on_user_prompt = false
  }

  username_configuration {
    case_sensitive = false
  }

  user_attribute_update_settings {
    attributes_require_verification_before_update = var.attributes_require_verification_before_update
  }

  dynamic "sms_configuration" {
    for_each = var.sms_configuration == null ? [] : [var.sms_configuration]
    content {
      external_id    = sms_configuration.value.external_id
      sns_caller_arn = sms_configuration.value.sns_caller_arn
      sns_region     = sms_configuration.value.sns_region
    }
  }

  dynamic "email_configuration" {
    for_each = var.email_configuration == null ? [] : [var.email_configuration]
    content {
      configuration_set      = email_configuration.value.configuration_set
      email_sending_account  = email_configuration.value.email_sending_account
      from_email_address     = email_configuration.value.from_email_address
      reply_to_email_address = email_configuration.value.reply_to_email_address
      source_arn             = email_configuration.value.source_arn
    }
  }

  dynamic "verification_message_template" {
    for_each = var.verification_message_template == null ? [] : [var.verification_message_template]
    content {
      default_email_option  = verification_message_template.value.default_email_option
      email_message         = verification_message_template.value.email_message
      email_message_by_link = verification_message_template.value.email_message_by_link
      email_subject         = verification_message_template.value.email_subject
      email_subject_by_link = verification_message_template.value.email_subject_by_link
      sms_message           = verification_message_template.value.sms_message
    }
  }

  account_recovery_setting {
    dynamic "recovery_mechanism" {
      for_each = var.account_recovery_setting
      content {
        name     = recovery_mechanism.value.name
        priority = recovery_mechanism.value.priority
      }
    }
  }

  admin_create_user_config {
    allow_admin_create_user_only = var.admin_create_user_config.allow_admin_create_user_only
    dynamic "invite_message_template" {
      for_each = var.admin_create_user_config.invite_message_template == null ? [] : [var.admin_create_user_config.invite_message_template]
      content {
        email_message = invite_message_template.value.email_message
        email_subject = invite_message_template.value.email_subject
        sms_message   = invite_message_template.value.sms_message
      }
    }
  }

  dynamic "schema" {
    for_each = var.attributes_schema
    content {
      name                     = schema.value.name
      attribute_data_type      = schema.value.type
      mutable                  = schema.value.mutable
      required                 = schema.value.required
      developer_only_attribute = false
      dynamic "string_attribute_constraints" {
        for_each = schema.value.string_attribute_constraints == null ? [] : [schema.value.string_attribute_constraints]
        content {
          max_length = lookup(string_attribute_constraints.value, "max_length", null)
          min_length = lookup(string_attribute_constraints.value, "min_length", null)
        }
      }
      dynamic "number_attribute_constraints" {
        for_each = schema.value.number_attribute_constraints == null ? [] : [schema.value.number_attribute_constraints]
        content {
          max_value = lookup(number_attribute_constraints.value, "max_value", null)
          min_value = lookup(number_attribute_constraints.value, "min_value", null)
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      password_policy,
      schema
    ]
  }

  tags = merge({
    Team        = "Alps-DevOps"
    Environment = var.environment
    Terraform   = "true"
    Owner       = "Trustonic"
    Name        = var.cognito_user_pool_name
  }, var.tags)
}

resource "random_password" "user_password" {
  count       = length(var.default_users)
  length      = 12
  special     = true
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "aws_cognito_user" "user" {
  count              = length(var.default_users)
  user_pool_id       = aws_cognito_user_pool.userpool.id
  username           = var.default_users[count.index].username
  password           = var.default_users[count.index].password
  message_action     = var.default_users[count.index].password != null ? "SUPPRESS" : "RESEND"
  temporary_password = var.default_users[count.index].password != null ? null : random_password.user_password[count.index].result

  attributes = {
    email          = var.default_users[count.index].email
    email_verified = true
    name           = var.default_users[count.index].username
  }
}

resource "aws_cognito_user_pool_client" "userpool_client" {
  count                                         = length(var.cognito_user_pool_clients)
  name                                          = var.cognito_user_pool_clients[count.index].name
  user_pool_id                                  = aws_cognito_user_pool.userpool.id
  callback_urls                                 = var.cognito_user_pool_clients[count.index].callback_urls
  default_redirect_uri                          = var.cognito_user_pool_clients[count.index].callback_urls[0]
  allowed_oauth_flows_user_pool_client          = true
  allowed_oauth_flows                           = distinct(concat(["code"], var.cognito_user_pool_clients[count.index].flows))
  allowed_oauth_scopes                          = distinct(concat(["email", "openid"], var.cognito_user_pool_clients[count.index].scopes))
  supported_identity_providers                  = ["COGNITO"]
  id_token_validity                             = var.cognito_user_pool_clients[count.index].id_token_validity
  access_token_validity                         = var.cognito_user_pool_clients[count.index].access_token_validity
  refresh_token_validity                        = var.cognito_user_pool_clients[count.index].refresh_token_validity
  enable_token_revocation                       = true
  enable_propagate_additional_user_context_data = true
  generate_secret                               = var.cognito_user_pool_clients.generate_secret
  explicit_auth_flows                           = var.cognito_user_pool_clients[count.index].explicit_auth_flows
  logout_urls                                   = var.cognito_user_pool_clients[count.index].logout_urls
}
