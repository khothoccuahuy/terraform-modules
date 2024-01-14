variable "environment" {
  type = string
}

variable "s3_bucket_name" {
  type = string
}

variable "s3_bucket_force_destroy" {
  type = bool
}

variable "certificate_domain" {
  type = string
}

variable "cloudfront_distribution_origin_id" {
  type = string
}

variable "cloudfront_distribution_enable" {
  type = bool
}

variable "cloudfront_distribution_ipv6_enable" {
  type = bool
}

variable "cloudfront_distribution_default_root_object" {
  type = string
}

variable "cloudfront_distribution_aliases" {
  type = list(string)
  //  description = "Route53 aliases for cloudfront resource"
  //  default = [""]
}

variable "cloudfront_distribution_default_cache_behavior_allowed_methods" {
  type = list(string)
  //  description = "List of allowed methods"
  //  default = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable "cloudfront_distribution_default_cache_behavior_cached_methods" {
  type = list(string)
  //  description = "List of cached methods"
  //  default = ["GET", "HEAD"]
}

variable "cloudfront_distribution_default_cache_behavior_target_origin_id" {
  type = string
}

variable "cloudfront_distribution_default_cache_behavior_protocol_policy" {
  type = string
  //  description = "Protocol policy: one of allow-all, https-only, or redirect-to-https"
  //  default = "https-only"
}

variable "cloudfront_distribution_default_cache_behavior_query_string" {
  type = bool
  default = null
  //  description = "Should cloudfront pass query string"
  //  default = false
}

variable "cloudfront_distribution_default_cache_behavior_cookies_forward" {
  type = string
  default = null
  //  description = "Cookie pass policy"
  //  default = "none"
}
variable "versioning" {
  description = "Map containing versioning configuration."
  type        = map(string)
  default     = {}
}
variable "cloudfront_distribution_default_cache_behavior_min_ttl" {
  type = number
  //  description = "Minimal TTL"
  //  default = 0
}
variable "cloudfront_distribution_default_cache_behavior_default_ttl" {
  type = number
  //  description = "Default TTL"
  //  default = 3600
}
variable "cloudfront_distribution_default_cache_behavior_max_ttl" {
  type = number
  //  description = "Maximal TTL"
  //  default = 86400
}
variable "cloudfront_distribution_default_cache_behavior_compress" {
  type = bool
  //  description = "Compression enabled"
  //  default = true
}

variable "inputs_error_responses" {
  type = list(object({
    error_caching_min_ttl = number
    error_code            = number
    response_code         = number
    response_page_path    = string
    })
  )
  default = []
  //  description = "Custom error responses"
  //  default = [
  //    {
  //      error_caching_min_ttl = 300
  //      error_code            = 404
  //      response_code         = 200
  //      response_page_path    = "/index.html"
  //    }]
}

variable "cloudfront_distribution_price_class" {
  type = string
  //  description = "Price class for distribution"
  //  default = "PriceClass_100"
}

variable "cloudfront_distribution_restriction_type" {
  type = string
  //  description = "Geo restriction type: whitelist, blacklist, none"
  //  default = "none"
}

variable "cloudfront_distribution_minimum_protocol_version" {
  type = string
  //  description = "SSL protocol minimal version"
  //  default = "TLSv1.1_2016"
}

variable "cloudfront_distribution_ssl_support_method" {
  type = string
}

variable "zone_id" {
  type = string
}

variable "dns_record" {
  type = string
}

variable "record_type" {
  type = string
}

variable "evaluate_target_health" {
  type = bool
}

variable "logging" {
  description = "Map containing access bucket logging configuration."
  type        = map(string)
  default     = {}
}

variable "expected_bucket_owner" {
  
}

variable "origin_access_identity_comment" {
  type = string
}

variable "acl" {
  description = "(Optional) The canned ACL to apply. Defaults to 'private'."
  #default     = "private"
  default = null
}

variable "cloudfront_distribution_web_acl_id" {
  type = string
  default = ""
}
variable "block_public_acls" {
  description = "Whether Amazon S3 should block public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "block_public_policy" {
  description = "Whether Amazon S3 should block public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "ignore_public_acls" {
  description = "Whether Amazon S3 should ignore public ACLs for this bucket."
  type        = bool
  default     = true
}

variable "restrict_public_buckets" {
  description = "Whether Amazon S3 should restrict public bucket policies for this bucket."
  type        = bool
  default     = true
}

variable "website" {
  description = "Map containing static web-site hosting or redirect configuration."
  type        = any # map(string)
  default     = {}
}

variable "include_cookies" {
  type= bool
  default = null
}

variable "tags" {
  type = map(string)
  default = {}
}
