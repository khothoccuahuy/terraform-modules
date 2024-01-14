variable "kinesis_data_stream_name" {
  type        = string
  description = "Kinesis data streams names"
}
variable "kinesis_data_shard_count" {
  type        = number
  description = "Number of shards in Kinesis"
  default     = 5
}
variable "kinesis_data_retention" {
  type        = number
  description = "Data retention time"
  default     = null
}
variable "environment" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

