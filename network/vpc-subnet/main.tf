resource "aws_subnet" "subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cird_block
  availability_zone = var.subnet_availability_zone

  tags = merge(
    {
      Environment = var.environment
      Name        = var.subnet_name
      Terraform   = "true"
    },
    var.tags
  )
}