resource "aws_db_instance" "db_instance" {
  storage_type                        = var.db_instance_storage_type
  snapshot_identifier                 = var.db_snapshot_identifier
  identifier                          = var.db_instance_identifier
  iam_database_authentication_enabled = var.db_iam_database_authentication_enabled
  license_model                       = var.db_license_model
  engine                              = var.db_instance_engine
  engine_version                      = var.db_instance_engine_version
  instance_class                      = var.db_instance_instance_class
  db_name                             = var.db_instance_name
  username                            = var.db_instance_username
  password                            = var.db_instance_password
  parameter_group_name                = var.db_instance_parameter_group
  option_group_name                   = var.db_instance_option_group
  allocated_storage                   = var.db_instance_storage
  copy_tags_to_snapshot               = var.db_instance_snapshot_tags
  db_subnet_group_name                = var.db_instance_subnet_name
  deletion_protection                 = var.db_instance_delete_protect
  storage_encrypted                   = var.db_instance_encryption
  kms_key_id                          = var.db_instance_kms_arn
  skip_final_snapshot                 = var.db_instance_skip_snapshot
  final_snapshot_identifier           = var.db_instance_final_snapshot_identifier
  backup_retention_period             = var.db_instance_backup_retention_period
  backup_window                       = var.db_instance_backup_window
  ca_cert_identifier                  = var.db_instance_cert_identifier
  maintenance_window                  = var.db_instance_maintenance_window
  auto_minor_version_upgrade          = var.db_instance_auto_minor_version_upgrade
  allow_major_version_upgrade         = var.db_instance_allow_major_version_upgrade
  monitoring_interval                 = var.db_instance_monitoring_interval
  vpc_security_group_ids              = var.db_instance_security_groups
  performance_insights_enabled        = var.db_instance_performance_insights_enabled
  publicly_accessible                 = var.db_instance_publicly_accessible
  apply_immediately                   = var.db_instance_apply_immediately

  tags = merge({
    Team        = "Alps-DevOps"
    Environment = var.environment
    Terraform   = "true"
    Name        = var.db_instance_identifier
  }, var.tags)

  lifecycle {
    ignore_changes = all
//    ignore_changes = [
//      engine_version
//    ]
  }
}
