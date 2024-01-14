variable "environment" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "cognito_user_pool_name" {
  type = string
}

variable "cognito_user_pool_alias_attributes" {
  type    = list(string)
  default = ["email", "preferred_username"]
}

variable "auto_verified_attributes" {
  type    = list(string)
  default = ["email"]
}

variable "mfa_configuration" {
  type    = string
  default = "OFF"
}

variable "email_verification_message" {
  type    = string
  default = "Hi {username}\nYour Verification Code is {####}"
}

variable "email_verification_subject" {
  type    = string
  default = "Email verification"
}

variable "sms_authentication_message" {
  type    = string
  default = "Your code is {####}"
}

variable "sms_verification_message" {
  type    = string
  default = "Your code is {####}"
}

variable "attributes_require_verification_before_update" {
  type    = list(string)
  default = ["email"]
}

variable "sms_configuration" {
  type = object({
    external_id    = string
    sns_caller_arn = string
    sns_region     = string
  })
  nullable = true
  default  = null
}

variable "email_configuration" {
  type = object({
    configuration_set      = string
    email_sending_account  = string
    from_email_address     = string
    reply_to_email_address = string
    source_arn             = string
  })

  default = {
    configuration_set      = null
    email_sending_account  = "COGNITO_DEFAULT"
    from_email_address     = null
    reply_to_email_address = null
    source_arn             = null
  }
}

variable "verification_message_template" {
  type = object({
    email_message         = string
    email_subject         = string
    sms_message           = string
    default_email_option  = string
    email_message_by_link = string
    email_subject_by_link = string
  })
  default = {
    default_email_option  = "CONFIRM_WITH_LINK"
    email_message_by_link = "Hi {username}\nClick <a href={##Click Here###}>here</a> to verify for your account"
    email_subject_by_link = "Email verification"
    email_message         = null
    email_subject         = null
    sms_message           = null
  }
}

variable "account_recovery_setting" {
  type = list(object({
    name     = string
    priority = number
  }))
  default = [{
    name     = "verified_email"
    priority = 1
  }]
}

variable "attributes_schema" {
  type = list(object({
    name                         = string
    type                         = string
    mutable                      = bool
    required                     = bool
    string_attribute_constraints = map(any)
    number_attribute_constraints = map(any)
  }))

  default = []
}

variable "admin_create_user_config" {
  type = object({
    allow_admin_create_user_only = bool
    invite_message_template = object({
      email_message = string
      email_subject = string
      sms_message   = string
    })
  })

  default = {
    allow_admin_create_user_only = true
    invite_message_template = {
      email_message = "Hi {username}\nYour account is already created the username is {username} and the temporary password is {####}"
      email_subject = "Account invitation"
      sms_message   = "Hi {username}\nYour confirmation code is {####}"
    }
  }
}

variable "default_users" {
  type = list(object({
    username = string
    email    = string
    password = string
  }))
  default = []
}

variable "cognito_user_pool_clients" {
  type = list(object({
    name                   = string
    generate_secret        = bool
    callback_urls          = list(string)
    flows                  = list(string)
    scopes                 = list(string)
    id_token_validity      = number
    access_token_validity  = number
    refresh_token_validity = number
    explicit_auth_flows    = list(string)
    logout_urls            = list(string)
  }))
}
