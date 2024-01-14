// Resource creation order
// 1. s3-bucket
// 2. CloudFront
// 3. CloudFront-Origin
// 4. s3-bucket-policy with contain cloudfront_origin_access_identity

locals {
  allowed2edit_apks = concat([for user in data.aws_iam_group.s3_administrator.users: user.arn], [data.aws_iam_role.cross_acc.arn, data.aws_iam_role.resource_service.arn], var.environment == "alps-partners" ? [data.aws_iam_user.connector_framework_sa.arn] : [])
}

data "aws_iam_role" "resource_service" {
  name = "${var.environment}-svc-resource-service-iam-role"
}

data "aws_iam_role" "cross_acc" {
  name = "AccessThrowDevelopmentAccount"
}

data "aws_iam_group" "s3_administrator" {
  group_name = "${var.environment}-s3-administrator"
}

data "aws_iam_user" "connector_framework_sa" {
  user_name = "connector_framework_sa"
}
data "aws_kms_key" "key" {
  key_id = "alias/aws/s3"
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = var.origin_access_identity_comment
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = var.s3_bucket_force_destroy

  tags = merge({
    Team        = "Alps-DevOps"
    Environment = var.environment
    Terraform   = "true"
    Owner       = "Trustonic"
    Name        = var.s3_bucket_name
  }, var.tags)
}

resource "aws_s3_bucket_website_configuration" "this" {
  count = length(keys(var.website)) > 0 ? 1 : 0

  bucket                = aws_s3_bucket.s3_bucket.id
  expected_bucket_owner = var.expected_bucket_owner

  dynamic "index_document" {
    for_each = try([var.website["index_document"]], [])

    content {
      suffix = index_document.value
    }
  }

  dynamic "error_document" {
    for_each = try([var.website["error_document"]], [])

    content {
      key = error_document.value
    }
  }

  dynamic "redirect_all_requests_to" {
    for_each = try([var.website["redirect_all_requests_to"]], [])

    content {
      host_name = redirect_all_requests_to.value.host_name
      protocol  = try(redirect_all_requests_to.value.protocol, null)
    }
  }

  dynamic "routing_rule" {
    for_each = try(flatten([var.website["routing_rules"]]), [])

    content {
      dynamic "condition" {
        for_each = [try([routing_rule.value.condition], [])]

        content {
          http_error_code_returned_equals = try(routing_rule.value.condition["http_error_code_returned_equals"], null)
          key_prefix_equals               = try(routing_rule.value.condition["key_prefix_equals"], null)
        }
      }

      redirect {
        host_name               = try(routing_rule.value.redirect["host_name"], null)
        http_redirect_code      = try(routing_rule.value.redirect["http_redirect_code"], null)
        protocol                = try(routing_rule.value.redirect["protocol"], null)
        replace_key_prefix_with = try(routing_rule.value.redirect["replace_key_prefix_with"], null)
        replace_key_with        = try(routing_rule.value.redirect["replace_key_with"], null)
      }
    }
  }
}

resource "aws_s3_bucket_logging" "this" {
  count = length(keys(var.logging)) > 0 ? 1 : 0

  bucket = aws_s3_bucket.s3_bucket.id

  target_bucket = var.logging["target_bucket"]
  target_prefix = try(var.logging["target_prefix"], null)
}

# need import, when block public access is ON
resource "aws_s3_bucket_public_access_block" "s3_bucket" {
  # to prevent "A conflicting conditional operation is currently in progress against s3_bucket resource."
  bucket                  = aws_s3_bucket.s3_bucket.id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_versioning" "this" {

  bucket                = aws_s3_bucket.s3_bucket.id
  expected_bucket_owner = var.expected_bucket_owner
  mfa                   = try(var.versioning["mfa"], null)

  versioning_configuration {
    # Valid values: "Enabled" or "Suspended"
    status = try(var.versioning["enabled"] ? "Enabled" : "Suspended", tobool(var.versioning["status"]) ? "Enabled" : "Suspended", title(lower(var.versioning["status"])))

    # Valid values: "Enabled" or "Disabled"
    mfa_delete = try(tobool(var.versioning["mfa_delete"]) ? "Enabled" : "Disabled", title(lower(var.versioning["mfa_delete"])), null)
  }
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    actions = [
      "s3:GetObject"
    ]
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }

    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}/*",
      "arn:aws:s3:::${var.s3_bucket_name}"
    ]
  }

  statement {
    actions = [
      "s3:PutObject*",
    ]
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    effect = "Deny"

    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}/*",
      "arn:aws:s3:::${var.s3_bucket_name}"
    ]
    condition {
      test     = "StringNotLike"
      variable = "aws:PrincipalArn"
      values   = local.allowed2edit_apks
    }
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = var.s3_bucket_name
  policy = data.aws_iam_policy_document.bucket_policy.json
}

//provider "aws" {
//  alias = "certificates"
//}

data "aws_acm_certificate" "certificate" {
  domain   = var.certificate_domain
  statuses = ["ISSUED"]
  provider = aws.certificates
}

resource "aws_cloudfront_distribution" "cloudfront_distribution" {
  origin {
    domain_name = aws_s3_bucket.s3_bucket.bucket_domain_name
    //    origin_id   = format("S3-%s", var.s3_bucket_name)
    origin_id = var.cloudfront_distribution_origin_id
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
    }
  }


  logging_config {
    bucket          = "${var.logging["target_bucket"]}.s3.amazonaws.com"
    include_cookies = var.include_cookies
  }


  enabled             = var.cloudfront_distribution_enable
  is_ipv6_enabled     = var.cloudfront_distribution_ipv6_enable
  default_root_object = var.cloudfront_distribution_default_root_object
  aliases             = var.cloudfront_distribution_aliases
  web_acl_id          = var.cloudfront_distribution_web_acl_id

  default_cache_behavior {
    allowed_methods        = var.cloudfront_distribution_default_cache_behavior_allowed_methods
    cached_methods         = var.cloudfront_distribution_default_cache_behavior_cached_methods
    target_origin_id       = var.cloudfront_distribution_default_cache_behavior_target_origin_id
    viewer_protocol_policy = var.cloudfront_distribution_default_cache_behavior_protocol_policy
    forwarded_values {
      query_string = var.cloudfront_distribution_default_cache_behavior_query_string
      cookies {
        forward = var.cloudfront_distribution_default_cache_behavior_cookies_forward
      }
    }

    min_ttl     = var.cloudfront_distribution_default_cache_behavior_min_ttl
    default_ttl = var.cloudfront_distribution_default_cache_behavior_default_ttl
    max_ttl     = var.cloudfront_distribution_default_cache_behavior_max_ttl
    compress    = var.cloudfront_distribution_default_cache_behavior_compress
  }

  dynamic "custom_error_response" {
    for_each = var.inputs_error_responses
    content {
      error_caching_min_ttl = lookup(custom_error_response.value, "error_caching_min_ttl")
      error_code            = lookup(custom_error_response.value, "error_code")
      response_code         = lookup(custom_error_response.value, "response_code")
      response_page_path    = lookup(custom_error_response.value, "response_page_path")
    }
  }

  price_class = var.cloudfront_distribution_price_class
  restrictions {
    geo_restriction {
      restriction_type = var.cloudfront_distribution_restriction_type

    }
  }

  tags = {
    Team        = "Alps-DevOps"
    Environment = var.environment
    "Terraform" = "true"
    "Owner"     = "Trustonic"
  }

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.certificate.arn
    minimum_protocol_version = var.cloudfront_distribution_minimum_protocol_version
    ssl_support_method       = var.cloudfront_distribution_ssl_support_method
    //    "sni-only"

  }
}

resource "aws_route53_record" "cloudfront_route53_record" {
  zone_id = var.zone_id
  name    = var.dns_record
  type    = var.record_type

  alias {
    name                   = aws_cloudfront_distribution.cloudfront_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.cloudfront_distribution.hosted_zone_id
    evaluate_target_health = var.evaluate_target_health
  }
}
