#!/bin/bash
terragrunt import "module.grafana_wizzy_bucket[0].aws_s3_bucket.s3_bucket.this[0]" grafana-wizzy
terragrunt import "module.grafana_wizzy_bucket[0].aws_s3_bucket_versioning.this[0]" grafana-wizzy,252590264222
terragrunt import "module.grafana_wizzy_bucket[0].aws_s3_bucket_public_access_block.this[0]" grafana-wizzy
terragrunt import "module.grafana_wizzy_bucket[0].aws_s3_bucket_policy.this[0]" grafana-wizzy

terragrunt state rm "module.grafana_wizzy_bucket[0].aws_s3_bucket_public_access_block.s3_bucket"
terragrunt state rm "module.grafana_wizzy_bucket[0].aws_s3_bucket_policy.s3_bucket[0]"
terragrunt state rm "module.grafana_wizzy_bucket[0].aws_s3_bucket.s3_bucket"
terragrunt state rm "module.grafana_wizzy_bucket.aws_s3_bucket_policy.this[0]"
terragrunt state rm "module.grafana_wizzy_bucket.aws_s3_bucket_versioning.this[0]"
terragrunt state rm "module.grafana_wizzy_bucket.aws_s3_bucket_public_access_block.this[0]"
terragrunt state rm "module.grafana_wizzy_bucket.aws_s3_bucket.this[0]"