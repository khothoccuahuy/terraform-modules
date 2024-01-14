variable "environment" {
  type        = string
  description = "Environment for deploy"
}

variable "tags" {
  type    = map(string)
  default = {}
}


variable "db_cluster_identifier" {
  type        = string
  description = "(Optional, Forces new resources) The cluster identifier. If omitted, Terraform will assign a random, unique identifier."
}

variable "db_cluster_engine" {
  type        = string
  description = "(Optional) The name of the database engine to be used for this DB cluster. Defaults to aurora. Valid Values: aurora, aurora-mysql, aurora-postgresql, mysql, postgres"
  default     = "aurora"
}

variable "db_cluster_engine_mode" {
  type        = string
  description = "(Optional) The database engine mode. Valid values: global (only valid for Aurora MySQL 1.21 and earlier), multimaster, parallelquery, provisioned, serverless. Defaults to: provisioned"
  default     = "provisioned"
}

variable "db_cluster_engine_version" {
  type        = string
  description = "(Optional) The database engine version."
  default     = null
}

variable "db_cluster_storage_type" {
  type        = string
  description = "Optional) Specifies the storage type to be associated with the DB cluster. (This setting is required to create a Multi-AZ DB cluster)."
  default     = "io1"
}

variable "db_cluster_allocated_storage" {
  type        = string
  description = "(Optional) The amount of storage in gibibytes (GiB) to allocate to each DB instance in the Multi-AZ DB cluster."
  default     = null
}

variable "db_cluster_iops" {
  type        = number
  description = "Optional) The amount of Provisioned IOPS (input/output operations per second) to be initially allocated for each DB instance in the Multi-AZ DB cluster."
  default     = null
}

variable "db_cluster_azs" {
  type        = list(string)
  description = "(Optional) List of EC2 Availability Zones for the DB cluster storage where DB cluster instances can be created."
  default     = []
}

variable "db_cluster_copy_tags_to_snapshot" {
  type        = bool
  description = "(Optional, boolean) Copy all Cluster tags to snapshots."
  default     = true
}

variable "db_cluster_instance_class" {
  type        = string
  description = "(Optional) The compute and memory capacity of each DB instance in the Multi-AZ DB cluster, for example db.m6g.xlarge."
}

variable "db_cluster_subnet_name" {
  type        = string
  description = "(Optional) A DB subnet group to associate with this DB instance. NOTE: This must match the db_subnet_group_name specified on every aws_rds_cluster_instance in the cluster."
}

variable "db_cluster_delete_protect" {
  type        = bool
  description = "Optional) If the DB instance should have deletion protection enabled."
  default     = false
}

variable "db_cluster_encryption" {
  type        = bool
  description = "(Optional) Specifies whether the DB cluster is encrypted."
  default     = false
}

variable "db_cluster_kms_arn" {
  type        = string
  description = "(Optional) The ARN for the KMS encryption key. When specifying kms_key_id, cluster_encryption needs to be set to true."
  default     = null
}

variable "db_cluster_skip_final_snapshot" {
  type        = bool
  description = "Optional) Determines whether a final DB snapshot is created before the DB cluster is deleted."
  default     = false
}

variable "db_cluster_final_snapshot_identifier" {
  type        = string
  description = "(Optional) Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot."
  default     = null
}

variable "db_cluster_backup_retention_period" {
  type        = number
  description = "(Optional) The days to retain backups for. Default 7"
  default     = 7
}

variable "db_cluster_preferred_backup_window" {
  type        = string
  description = "Optional) The daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC. Default: A 30-minute window selected at random from an 8-hour block of time per regionE.g., 04:00-09:00"
  default     = null
}

variable "db_cluster_preferred_maintenance_window" {
  type        = string
  description = "(Optional) The weekly time range during which system maintenance can occur, in (UTC) e.g., wed0400-wed0430"
  default     = null
}

variable "db_cluster_restore_to_point_in_time" {
  type = list(object({
    source_cluster_identifier  = string
    restore_type               = string
    use_latest_restorable_time = bool
  }))
  default     = []
  description = "List point-in-time recovery options. Only valid actions are `source_cluster_identifier`, `restore_type` and `use_latest_restorable_time`"
}

variable "db_cluster_allow_major_version_upgrade" {
  type        = bool
  description = "(Optional) Enable to allow major engine version upgrades when changing engine versions. Defaults to false."
  default     = false
}

variable "db_cluster_security_groups" {
  type        = list(string)
  description = "(Optional) List of VPC security groups to associate with the Cluster."
  default     = []
}

variable "db_cluster_enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "(Optional) Set of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: audit, error, general, slowquery, postgresql (PostgreSQL)."
  default     = []
}

variable "db_cluster_parameter_group_name" {
  type        = string
  description = "(Optional) A cluster parameter group to associate with the cluster."
  default     = null
}

variable "db_instance_parameter_group_name" {
  type        = string
  description = "(Optional) Instance parameter group to associate with all instances of the DB cluster. The db_instance_parameter_group_name parameter is only valid in combination with the allow_major_version_upgrade parameter."
  default     = null
}

variable "db_cluster_db_name" {
  type        = string
  description = "(Optional) Name for an automatically created database on cluster creation."
  default     = null
}

variable "db_cluster_master_username" {
  type        = string
  description = "(Required unless a snapshot_identifier or replication_source_identifier is provided or unless a global_cluster_identifier is provided when the cluster is the secondary cluster of a global database) Username for the master DB user."
  default     = null
}

variable "db_cluster_master_password" {
  type        = string
  description = "Required unless a snapshot_identifier or replication_source_identifier is provided or unless a global_cluster_identifier is provided when the cluster is the secondary cluster of a global database) Password for the master DB user."
  default     = null
}

variable "db_cluster_scaling_configuration" {
  type = list(object({
    auto_pause               = bool
    min_capacity             = number
    max_capacity             = number
    seconds_until_auto_pause = number
    timeout_action           = string
  }))
  description = "(Optional) Map of nested attributes with scaling properties. Only valid when `engine_mode` is set to `serverless`"
  default     = []
}

variable "db_cluster_serverlessv2_scaling_configuration" {
  type = object({
    min_capacity = number
    max_capacity = number
  })
  description = "(Optional) Map of nested attributes with serverless v2 scaling properties. Only valid when `engine_mode` is set to `provisioned`"
  default     = null
}
