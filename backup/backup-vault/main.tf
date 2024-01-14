resource "aws_backup_vault" "backup_vault" {
  name        = var.name
  kms_key_arn = var.kms_key_arn
}