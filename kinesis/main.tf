resource "aws_kinesis_stream" "kinesis_data_stream" {
  name             = var.kinesis_data_stream_name
  shard_count      = var.kinesis_data_shard_count
  retention_period = var.kinesis_data_retention
  encryption_type  = "KMS"
  kms_key_id       = "alias/aws/kinesis"

  tags = merge({
    Team        = "Alps-DevOps"
    Environment = var.environment
    Terraform   = "true"
    Name        = var.kinesis_data_stream_name
  }, var.tags)
}