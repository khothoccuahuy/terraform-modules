resource "aws_cloudwatch_log_stream" "aws_cloudwatch_log_stream" {
  name           = var.cloudwatch_log_stream_name
  log_group_name = var.cloudwatch_log_group_name
}