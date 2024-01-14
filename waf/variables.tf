variable "environment" {
  type = string
}

variable "waf_name" {
}

variable "waf_scope" {
}

variable "waf_default_action" {
  type = string
}

variable "waf_managed_rules" {
  type = list(object({
    name            = string
    priority        = number
    override_action = string
    excluded_rules  = list(string)
    vendor_name     = string
  }))
  default = [
    {
      "excluded_rules" : [],
      "name" : "AWSManagedRulesCommonRuleSet",
      "override_action" : "none",
      "priority" : 10,
      "vendor_name" : "AWS"
    },
    {
      "excluded_rules" : [],
      "name" : "AWSManagedRulesAmazonIpReputationList",
      "override_action" : "none",
      "priority" : 20,
      "vendor_name" : "AWS"
    },
    {
      "excluded_rules" : [],
      "name" : "AWSManagedRulesKnownBadInputsRuleSet",
      "override_action" : "none",
      "priority" : 30,
      "vendor_name" : "AWS"
    },
    {
      "excluded_rules" : [],
      "name" : "AWSManagedRulesSQLiRuleSet",
      "override_action" : "none",
      "priority" : 40,
      "vendor_name" : "AWS"
    },
    {
      "excluded_rules" : [],
      "name" : "AWSManagedRulesLinuxRuleSet",
      "override_action" : "none",
      "priority" : 50,
      "vendor_name" : "AWS"
    },
    {
      "excluded_rules" : [],
      "name" : "AWSManagedRulesUnixRuleSet",
      "override_action" : "none",
      "priority" : 60,
      "vendor_name" : "AWS"
    }
  ]
}

variable "ip_sets_rule" {
  type = list(object({
    name          = string
    priority      = number
    ip_set_arn    = string
    action        = string
    response_code = optional(number, 403)
  }))
  description = "A rule to detect web requests coming from particular IP addresses or address ranges."
  default     = []
}

variable "waf_resource_associate_arns" {
  type    = list(string)
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
