variable "environment" {
  type        = string
  description = "Environment for deploy"
}
variable "db_instance_skip_snapshot" {
  type        = bool
  description = "Skip snapshot before deleting"
  default     = false
}

variable "db_instance_auto_minor_version_upgrade" {
  type        = bool
  description = "Allow minor upgrade"
  default     = false
}

variable "db_instance_allow_major_version_upgrade" {
  type        = bool
  description = "Allow major upgrade"
  default     = false
}

variable "db_instance_storage_type" {
  type        = string
  description = "DB instance storage type"
  default     = "gp2"
}
variable "db_instance_engine" {
  type        = string
  description = "DB instance engine"
}
variable "db_instance_engine_version" {
  type        = string
  description = "DB instance engine version"
}
variable "db_instance_instance_class" {
  type        = string
  description = "DB instance type"
}
variable "db_instance_name" {
  type        = string
  description = "Database name"
}
variable "db_instance_username" {
  type        = string
  description = "Database username"
}
variable "db_instance_password" {
  type        = string
  description = "Database password"
  default     = ""
}
variable "db_instance_parameter_group" {
  type        = string
  description = "DB instance parameter group name"
}
variable "db_instance_option_group" {
  type = string
}
variable "db_instance_storage" {
  type        = number
  description = "DB instance storage size"
  default     = 5
}
variable "db_instance_monitoring_interval" {
  type        = number
  description = "DB Monitoring interval"
  default     = 0
}
variable "db_instance_snapshot_tags" {
  type        = bool
  description = "Add tags to snapshots"
  default     = true
}
variable "db_instance_delete_protect" {
  type        = bool
  description = "Enable delete protection"
  default     = false
}
variable "db_instance_encryption" {
  type        = bool
  description = "Enable DB instance storage encryption"
  default     = false
}
variable "db_instance_kms_arn" {
  type        = string
  description = "Database username"
  default     = ""
}
variable "db_instance_backup_retention_period" {
  type        = number
  description = "Backup retention period"
  default     = null
}
variable "db_instance_backup_window" {
  type        = string
  description = "Backup window"
  default     = ""
}
variable "db_instance_cert_identifier" {
  type        = string
  description = "Cert identifier"
  default     = ""
}

variable "db_instance_maintenance_window" {
  type        = string
  description = "Maintenance window."
  default     = ""
}

variable "db_instance_subnet_name" {
  type        = string
  description = "Subnet group name"
}

variable "db_instance_security_groups" {
  type        = list(string)
  description = "DB Instance security group ids"
}

variable "db_instance_performance_insights_enabled" {
  type    = bool
  default = false
}

variable "db_instance_publicly_accessible" {
  type    = bool
  default = false
}
variable "db_snapshot_identifier" {
  default = null
}
variable "db_license_model" {
  type = string
}
variable "db_instance_identifier" {
  type = string
}
variable "db_iam_database_authentication_enabled" {
  type    = bool
  default = true
}

variable "db_instance_apply_immediately" {
  type    = bool
  default = true
}
variable "db_instance_final_snapshot_identifier" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
