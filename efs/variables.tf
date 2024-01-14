variable "environment" {
  type = string
}

variable "owner" {
  type = string
}

variable "efs_encrypted" {
  type        = bool
  description = "If true, the file system will be encrypted"
  default     = true
}

variable "efs_kms_key_id" {
  type        = string
  description = "If set, use a specific KMS key"
}

variable "efs_performance_mode" {
  type        = string
  description = "The file system performance mode. Can be either `generalPurpose` or `maxIO`"
  default     = "generalPurpose"
}

variable "efs_provisioned_throughput_in_mibps" {
  default     = 0
  description = "The throughput, measured in MiB/s, that you want to provision for the file system. Only applicable with `throughput_mode` set to provisioned"
}

variable "efs_throughput_mode" {
  type        = string
  description = "Throughput mode for the file system. Defaults to bursting. Valid values: `bursting`, `provisioned`. When using `provisioned`, also set `provisioned_throughput_in_mibps`"
  default     = "bursting"
}

variable "efs_transition_to_ia" {
  type        = string
  description = "Indicates how long it takes to transition files to the IA storage class. Valid values: AFTER_7_DAYS, AFTER_14_DAYS, AFTER_30_DAYS, AFTER_60_DAYS and AFTER_90_DAYS"
  default     = ""
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs"
}

variable "efs_security_group_id" {
  type = string
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "efs_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
