#!/bin/bash

# Invalid resource instance data in state
terragrunt state rm "module.dynamo_db_table_datastore_admin.aws_dynamodb_table.dynamodb_table"
terragrunt state rm "module.dynamo_db_table_datastore_device.aws_dynamodb_table.dynamodb_table"
terragrunt state rm "module.dynamo_db_table_datastore_scheduled_events.aws_dynamodb_table.dynamodb_table"
terragrunt state rm "module.dynamo_db_table_resource_oemconfig.aws_dynamodb_table.dynamodb_table"
terragrunt state rm "module.dynamo_db_table_datastore_milestone.aws_dynamodb_table.dynamodb_table"
terragrunt state rm "module.dynamo_db_table_datastore_provisioning.aws_dynamodb_table.dynamodb_table"
terragrunt state rm "module.dynamo_db_table_datastore_policy.aws_dynamodb_table.dynamodb_table"
terragrunt state rm "module.dynamo_db_table_identity_tac.aws_dynamodb_table.dynamodb_table"
terragrunt state rm "module.dynamo_db_table_datastore_devicepos_auditlog.aws_dynamodb_table.dynamodb_table"
terragrunt state rm "module.stealth_dynamodb.aws_dynamodb_table.dynamodb_table"

terragrunt import "module.dynamo_db_table_datastore_admin.aws_dynamodb_table.dynamodb_table" alps-dev-svc-dynamodb-datastore_Admin
terragrunt import "module.dynamo_db_table_datastore_device.aws_dynamodb_table.dynamodb_table" alps-dev-svc-dynamodb-datastore_Device
terragrunt import "module.dynamo_db_table_datastore_scheduled_events.aws_dynamodb_table.dynamodb_table" alps-dev-svc-dynamodb-datastore_ScheduledEvents
terragrunt import "module.dynamo_db_table_resource_oemconfig.aws_dynamodb_table.dynamodb_table" alps-dev-svc-resource-service_OEMConfig
terragrunt import "module.dynamo_db_table_datastore_milestone.aws_dynamodb_table.dynamodb_table" alps-dev-svc-dynamodb-datastore_Milestone
terragrunt import "module.dynamo_db_table_datastore_provisioning.aws_dynamodb_table.dynamodb_table" alps-dev-svc-dynamodb-datastore_Provisioning
terragrunt import "module.dynamo_db_table_datastore_policy.aws_dynamodb_table.dynamodb_table" alps-dev-svc-dynamodb-datastore_Policy
terragrunt import "module.dynamo_db_table_identity_tac.aws_dynamodb_table.dynamodb_table" alps-dev-svc-identity-service_TAC
terragrunt import "module.dynamo_db_table_datastore_devicepos_auditlog.aws_dynamodb_table.dynamodb_table" alps-dev-svc-dynamodb-datastore_DevicePOS_AUDITLOG
terragrunt import "module.stealth_dynamodb.aws_dynamodb_table.dynamodb_table" alps-dev-stealth

# alps-dev-dynamodb-admin-stream
terragrunt import "module.kinesis_s3_dynamodb_admin_stream.aws_s3_bucket.this[0]" alps-dev-dynamodb-admin-stream && \
terragrunt import "module.kinesis_s3_dynamodb_admin_stream.aws_s3_bucket_versioning.this[0]" alps-dev-dynamodb-admin-stream,252590264222 && \
terragrunt import "module.kinesis_s3_dynamodb_admin_stream.aws_s3_bucket_public_access_block.this[0]" alps-dev-dynamodb-admin-stream && \
terragrunt import "module.kinesis_s3_dynamodb_admin_stream.aws_s3_bucket_server_side_encryption_configuration.this[0]" alps-dev-dynamodb-admin-stream,252590264222 && \
terragrunt import "module.kinesis_s3_dynamodb_admin_stream.aws_s3_bucket_acl.this[0]" alps-dev-dynamodb-admin-stream,private && \

terragrunt state rm "module.kinesis_s3_dynamodb_admin_stream.aws_s3_bucket.s3_bucket" && \
terragrunt state rm "module.kinesis_s3_dynamodb_admin_stream.aws_s3_bucket_public_access_block.s3_bucket"

# alps-dev-dynamodb-device-stream
terragrunt import "module.kinesis_s3_dynamodb_device_stream.aws_s3_bucket.this[0]" alps-dev-dynamodb-device-stream && \
terragrunt import "module.kinesis_s3_dynamodb_device_stream.aws_s3_bucket_versioning.this[0]" alps-dev-dynamodb-device-stream,252590264222 && \
terragrunt import "module.kinesis_s3_dynamodb_device_stream.aws_s3_bucket_public_access_block.this[0]" alps-dev-dynamodb-device-stream && \
terragrunt import "module.kinesis_s3_dynamodb_device_stream.aws_s3_bucket_server_side_encryption_configuration.this[0]" alps-dev-dynamodb-device-stream,252590264222 && \
terragrunt import "module.kinesis_s3_dynamodb_device_stream.aws_s3_bucket_acl.this[0]" alps-dev-dynamodb-device-stream,private && \

terragrunt state rm "module.kinesis_s3_dynamodb_device_stream.aws_s3_bucket.s3_bucket" && \
terragrunt state rm "module.kinesis_s3_dynamodb_device_stream.aws_s3_bucket_public_access_block.s3_bucket"

# alps-dev-dynamodb-milestone-stream
terragrunt import "module.kinesis_s3_dynamodb_milestone_stream.aws_s3_bucket.this[0]" alps-dev-dynamodb-milestone-stream && \
terragrunt import "module.kinesis_s3_dynamodb_milestone_stream.aws_s3_bucket_versioning.this[0]" alps-dev-dynamodb-milestone-stream,252590264222 && \
terragrunt import "module.kinesis_s3_dynamodb_milestone_stream.aws_s3_bucket_public_access_block.this[0]" alps-dev-dynamodb-milestone-stream && \
terragrunt import "module.kinesis_s3_dynamodb_milestone_stream.aws_s3_bucket_server_side_encryption_configuration.this[0]" alps-dev-dynamodb-milestone-stream,252590264222 && \
terragrunt import "module.kinesis_s3_dynamodb_milestone_stream.aws_s3_bucket_acl.this[0]" alps-dev-dynamodb-milestone-stream,private && \

terragrunt state rm "module.kinesis_s3_dynamodb_milestone_stream.aws_s3_bucket.s3_bucket" && \
terragrunt state rm "module.kinesis_s3_dynamodb_milestone_stream.aws_s3_bucket_public_access_block.s3_bucket"

# alps-dev-dynamodb-policy-stream
terragrunt import "module.kinesis_s3_dynamodb_policy_stream.aws_s3_bucket.this[0]" alps-dev-dynamodb-policy-stream && \
terragrunt import "module.kinesis_s3_dynamodb_policy_stream.aws_s3_bucket_versioning.this[0]" alps-dev-dynamodb-policy-stream,252590264222 && \
terragrunt import "module.kinesis_s3_dynamodb_policy_stream.aws_s3_bucket_public_access_block.this[0]" alps-dev-dynamodb-policy-stream && \
terragrunt import "module.kinesis_s3_dynamodb_policy_stream.aws_s3_bucket_server_side_encryption_configuration.this[0]" alps-dev-dynamodb-policy-stream,252590264222 && \
terragrunt import "module.kinesis_s3_dynamodb_policy_stream.aws_s3_bucket_acl.this[0]" alps-dev-dynamodb-policy-stream,private && \

terragrunt state rm "module.kinesis_s3_dynamodb_policy_stream.aws_s3_bucket.s3_bucket" && \
terragrunt state rm "module.kinesis_s3_dynamodb_policy_stream.aws_s3_bucket_public_access_block.s3_bucket"

# alps-dev-airflow-dwh-logs
terragrunt import "module.s3_airflow_dwh_logs[0].aws_s3_bucket.this[0]" alps-dev-airflow-dwh-logs && \
terragrunt import "module.s3_airflow_dwh_logs[0].aws_s3_bucket_public_access_block.this[0]" alps-dev-airflow-dwh-logs && \
terragrunt import "module.s3_airflow_dwh_logs[0].aws_s3_bucket_lifecycle_configuration.this[0]" alps-dev-airflow-dwh-logs,252590264222 && \
terragrunt import "module.s3_airflow_dwh_logs[0].aws_s3_bucket_acl.this[0]" alps-dev-airflow-dwh-logs,private && \

terragrunt state rm "module.s3_airflow_dwh_logs.aws_s3_bucket.s3_bucket" && \
terragrunt state rm "module.s3_airflow_dwh_logs.aws_s3_bucket_public_access_block.s3_bucket"

# alps-dev-airflow-logs
terragrunt import "module.s3_airflow_logs.aws_s3_bucket.this[0]" alps-dev-airflow-logs && \
terragrunt import "module.s3_airflow_logs.aws_s3_bucket_public_access_block.this[0]" alps-dev-airflow-logs && \
terragrunt import "module.s3_airflow_logs.aws_s3_bucket_lifecycle_configuration.this[0]" alps-dev-airflow-logs,252590264222 && \
terragrunt import "module.s3_airflow_logs.aws_s3_bucket_acl.this[0]" alps-dev-airflow-logs,private && \

terragrunt state rm "module.s3_airflow_logs.aws_s3_bucket.s3_bucket" && \
terragrunt state rm "module.s3_airflow_logs.aws_s3_bucket_public_access_block.s3_bucket"

# alps-dev-dynamodb-audit-records
terragrunt import "module.s3_dynamodb_audit_records.aws_s3_bucket.this[0]" alps-dev-dynamodb-audit-records && \
terragrunt import "module.s3_dynamodb_audit_records.aws_s3_bucket_public_access_block.this[0]" alps-dev-dynamodb-audit-records && \
terragrunt import "module.s3_dynamodb_audit_records.aws_s3_bucket_lifecycle_configuration.this[0]" alps-dev-dynamodb-audit-records,252590264222 && \
terragrunt import "module.s3_dynamodb_audit_records.aws_s3_bucket_acl.this[0]" alps-dev-dynamodb-audit-records,private && \

terragrunt state rm "module.s3_dynamodb_audit_records.aws_s3_bucket.s3_bucket" && \
terragrunt state rm "module.s3_dynamodb_audit_records.aws_s3_bucket_public_access_block.s3_bucket"

# cloudtrail-audit-ddb-alps-dev-svc-dynamodb-datastore-admin
terragrunt import "module.cloudtrail_audit_ddb_table_datastore_admin.module.s3_cloudtrail_audit_ddb.aws_s3_bucket.this[0]" cloudtrail-audit-ddb-alps-dev-svc-dynamodb-datastore-admin && \
terragrunt import "module.cloudtrail_audit_ddb_table_datastore_admin.module.s3_cloudtrail_audit_ddb.aws_s3_bucket_versioning.this[0]" cloudtrail-audit-ddb-alps-dev-svc-dynamodb-datastore-admin,252590264222 && \
terragrunt import "module.cloudtrail_audit_ddb_table_datastore_admin.module.s3_cloudtrail_audit_ddb.aws_s3_bucket_public_access_block.this[0]" cloudtrail-audit-ddb-alps-dev-svc-dynamodb-datastore-admin && \
terragrunt import "module.cloudtrail_audit_ddb_table_datastore_admin.module.s3_cloudtrail_audit_ddb.aws_s3_bucket_lifecycle_configuration.this[0]" cloudtrail-audit-ddb-alps-dev-svc-dynamodb-datastore-admin,252590264222 && \
terragrunt import "module.cloudtrail_audit_ddb_table_datastore_admin.module.s3_cloudtrail_audit_ddb.aws_s3_bucket_acl.this[0]" cloudtrail-audit-ddb-alps-dev-svc-dynamodb-datastore-admin,private && \
terragrunt import "module.cloudtrail_audit_ddb_table_datastore_admin.module.s3_cloudtrail_audit_ddb.aws_s3_bucket_policy.this[0]" cloudtrail-audit-ddb-alps-dev-svc-dynamodb-datastore-admin && \

terragrunt state rm "module.cloudtrail_audit_ddb_table_datastore_admin.module.s3_cloudtrail_audit_ddb.aws_s3_bucket.s3_bucket" && \
terragrunt state rm "module.cloudtrail_audit_ddb_table_datastore_admin.module.s3_cloudtrail_audit_ddb.aws_s3_bucket_public_access_block.s3_bucket" && \
terragrunt state rm "module.cloudtrail_audit_ddb_table_datastore_admin.module.s3_cloudtrail_audit_ddb.aws_s3_bucket_policy.s3_bucket[0]"