locals {
  name = lower(replace("cloudtrail-audit-ddb-${var.table_name}", "_", "-"))
}

resource "aws_cloudtrail" "default" {
  name                          = local.name
  s3_bucket_name                = module.s3_cloudtrail_audit_ddb.s3_bucket_id
  include_global_service_events = false

  event_selector {
    read_write_type           = "WriteOnly"
    include_management_events = false

    data_resource {
      type   = "AWS::DynamoDB::Table"
      values = ["arn:aws:dynamodb:${var.region}:${var.account_id}:table/${var.table_name}"]
    }
  }
  depends_on = [
    module.s3_cloudtrail_audit_ddb
  ]
}

data "aws_iam_policy_document" "default" {
  statement {
    sid = "AWSCloudTrailAclCheck"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl",
    ]

    resources = [
      "arn:aws:s3:::${local.name}",
    ]
  }

  statement {
    sid = "AWSCloudTrailWrite"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com", "config.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${local.name}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control",
      ]
    }
  }
}

module "s3_cloudtrail_audit_ddb" {
  source = "../s3"
  bucket = local.name

  acl = "private"
  expected_bucket_owner = var.account_id
  policy = data.aws_iam_policy_document.default.json
  attach_policy = true

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  lifecycle_rule = [
    {
      id                                     = "Transition audit logs"
      enabled                                = true
      transition = [
        {
          days          = 30
          storage_class = "GLACIER"
        }
      ]
      expiration = {
        days                         = 365
        expired_object_delete_marker = false
      }
    }
  ]

  versioning = {
    enabled = false
  }

  tags = merge({
    Team        = "Alps-DevOps"
    Name        = local.name
    Environment = var.environment
    Terraform   = "true"
    Owner       = "Trustonic"
  }, var.tags)

  depends_on = [
    data.aws_iam_policy_document.default
  ]
}
