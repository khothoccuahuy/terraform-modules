variable "kinesis_firehose_stream_name" {
  type = string
}
variable "destination_type" {
  type = string
}
variable "s3_destination_bucket_arn" {
  type = string
}
variable "iam_firehose_role_arn" {
  type = string
}
variable "kinesis_source_stream_arn" {
  type = string
}
variable "environment" {
  type = string
}
variable "owner" {
  type = string
}
variable "extended_s3_configuration_buffering_size" {
  type = number
}
variable "extended_s3_configuration_compression_format" {
  type = string
}
variable "extended_s3_configuration_s3_backup_mode" {
  type = string
}
variable "cloudwatch_logging_options_enabled" {
  type = bool
}
variable "cloudwatch_logging_options_log_group_name" {
  type    = string
  default = null
}
variable "cloudwatch_logging_options_log_stream_name" {
  type    = string
  default = null
}
variable "processing_configuration_enabled" {
  type = bool
}

variable "extended_s3_configuration_prefix" {
  type    = string
  default = null
}

variable "extended_s3_configuration_error_output_prefix" {
  type    = string
  default = null
}

variable "extended_s3_configuration_kms_key_arn" {
  type    = string
  default = null
}

variable "processors_lambda_arn" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
