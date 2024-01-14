resource "aws_eip" "elastic_ip" {
  vpc = var.vpc

  tags = merge({
    "Environment" = var.environment
    "Name"        = var.elastic_ip_name
    "Managed-by"  = "Terraform"
  }, var.tags)
}