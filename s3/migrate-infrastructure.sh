#!/bin/bash

terragrunt apply -target="module.trustonic_apls_qa_apks_logs_bucket" -target="module.apk_bucket" -target="module.auto_env_shutdown_asg_states"

# trustonic_apls_qa_apks_logs_bucket
terragrunt import "module.trustonic_apls_qa_apks_logs_bucket.aws_s3_bucket.this[0]" trustonic-alps-prod-apks-logs && \
terragrunt import "module.trustonic_apls_qa_apks_logs_bucket.aws_s3_bucket_public_access_block.this[0]" trustonic-alps-prod-apks-logs && \
terragrunt import "module.trustonic_apls_qa_apks_logs_bucket.aws_s3_bucket_acl.this[0]" trustonic-alps-prod-apks-logs,null && \

terragrunt state rm "module.trustonic_apls_qa_apks_logs_bucket.aws_s3_bucket.s3_bucket" && \
terragrunt state rm "module.trustonic_apls_qa_apks_logs_bucket.aws_s3_bucket_public_access_block.s3_bucket" && \

terragrunt import "module.s3_cloudfront_apk_bucket[0].aws_s3_bucket_logging.this[0]" trustonic-alps-prod-apks && \

# apk_bucket
terragrunt import "module.apk_bucket[0].aws_s3_bucket.this[0]" trustonic-alps-prod-apks && \
terragrunt import "module.apk_bucket[0].aws_s3_bucket_public_access_block.this[0]" trustonic-alps-prod-apks && \
terragrunt import "module.apk_bucket[0].aws_s3_bucket_versioning.this[0]" trustonic-alps-prod-apks,595804858763

terragrunt state rm "module.apk_bucket[0].aws_s3_bucket.s3_bucket" && \
terragrunt state rm "module.apk_bucket[0].aws_s3_bucket_public_access_block.s3_bucket" && \

# auto_env_shutdown_asg_states
terragrunt import "module.auto_env_shutdown_asg_states.aws_s3_bucket.this[0]" alps-prod-auto-env-shutdown-asg-states && \
terragrunt import "module.auto_env_shutdown_asg_states.aws_s3_bucket_public_access_block.this[0]" alps-prod-auto-env-shutdown-asg-states && \
terragrunt import "module.auto_env_shutdown_asg_states.aws_s3_bucket_acl.this[0]" alps-prod-auto-env-shutdown-asg-states,private && \

terragrunt state rm "module.auto_env_shutdown_asg_states.aws_s3_bucket.s3_bucket" && \
terragrunt state rm "module.auto_env_shutdown_asg_states.aws_s3_bucket_public_access_block.s3_bucket"
