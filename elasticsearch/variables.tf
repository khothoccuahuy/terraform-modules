variable "domain_name" {
  type = string
}
variable "elasticsearch_version" {
  type = string
}
variable "dedicated_master_count" {
  type = number
}
variable "dedicated_master_enabled" {
  type = bool
}
variable "dedicated_master_type" {
  type = string
}
variable "instance_count" {
  type = number
}
variable "instance_type" {
  type = string
}
variable "zone_awareness_enabled" {
  type = bool
}
variable "security_group_ids" {
  type = list(string)
}
variable "subnet_ids" {
  type = list(string)
}
variable "ebs_options" {
  type = object({
    ebs_enabled = bool
    iops        = number
    volume_size = number
    volume_type = string
  })
}
variable "encrypt_at_rest_enabled" {
  type    = bool
  default = true
}
variable "node_to_node_encryption_enabled" {
  type    = bool
  default = true
}
variable "snapshot_options_automated_snapshot_start_hour" {
  type = number
}
variable "environment" {
  type = string
}
variable "region" {
  type = string
}
variable "account_id" {
  type = string
}
variable "advanced_options" {
  type    = map(string)
  default = {}
}
variable "kms_key_id" {
  type    = string
  default = null
}
variable "zone_awareness_config_availability_zone_count" {
  type    = number
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
