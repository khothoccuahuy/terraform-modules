output "kinesis_data_stream_arn" {
  value = aws_kinesis_stream.kinesis_data_stream.arn
}

output "kinesis_data_stream_name" {
  value = aws_kinesis_stream.kinesis_data_stream.name
}