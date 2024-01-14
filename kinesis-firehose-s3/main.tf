resource "aws_kinesis_firehose_delivery_stream" "extended_s3_stream" {
  name        = var.kinesis_firehose_stream_name
  destination = var.destination_type

  kinesis_source_configuration {
    kinesis_stream_arn = var.kinesis_source_stream_arn
    role_arn           = var.iam_firehose_role_arn
  }

  extended_s3_configuration {
    role_arn            = var.iam_firehose_role_arn
    bucket_arn          = var.s3_destination_bucket_arn
    buffering_size      = var.extended_s3_configuration_buffering_size
    compression_format  = var.extended_s3_configuration_compression_format
    s3_backup_mode      = var.extended_s3_configuration_s3_backup_mode
    prefix              = var.extended_s3_configuration_prefix
    error_output_prefix = var.extended_s3_configuration_error_output_prefix
    kms_key_arn         = var.extended_s3_configuration_kms_key_arn

    cloudwatch_logging_options {
      enabled         = var.cloudwatch_logging_options_enabled
      log_group_name  = var.cloudwatch_logging_options_log_group_name
      log_stream_name = var.cloudwatch_logging_options_log_stream_name
    }

    processing_configuration {
      enabled = var.processing_configuration_enabled

      processors {
        type = "Lambda"

        parameters {
          parameter_name  = "LambdaArn"
          parameter_value = var.processors_lambda_arn
        }
        # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kinesis_firehose_delivery_stream
        # according to the documentation it is better to include only values which is different from default
        #        parameters {
        #          parameter_name  = "BufferIntervalInSeconds"
        #          parameter_value = "60"
        #        }
        #
        #        parameters {
        #          parameter_name  = "BufferSizeInMBs"
        #          parameter_value = "3"
        #        }
      }
    }
  }


  tags = merge({
    Team        = "Alps-DevOps"
    Environment = var.environment
    Terraform   = "true"
    Name        = var.kinesis_firehose_stream_name
  }, var.tags)

}
