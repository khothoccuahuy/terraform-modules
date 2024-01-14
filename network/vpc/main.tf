resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = var.vpc_enable_dns_support
  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  instance_tenancy     = var.vpc_instance_tenancy

  tags = merge(
    {
      Environment = var.environment
      Name        = var.vpc_name
      Terraform   = "true"
    },
    var.tags
  )

}