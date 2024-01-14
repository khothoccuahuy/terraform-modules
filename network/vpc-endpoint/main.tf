resource "aws_vpc_endpoint" "s3" {
  count = var.s3_endpoint_enable ? 1 : 0
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.s3"
  policy              = var.endpoint_policy
  private_dns_enabled = false
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids

  tags = merge({
    Team        = "Alps-DevOps"
    Name        = "${var.environment}-s3-eks"
    Environment = var.environment
    Managed-by  = "Terraform"
    Owner       = var.owner
  }, var.tags)
}

resource "aws_vpc_endpoint_security_group_association" "sg_s3" {
  count = var.s3_endpoint_enable ? 1 : 0
  vpc_endpoint_id   = aws_vpc_endpoint.s3[0].id
  security_group_id = var.security_group_id
}

resource "aws_vpc_endpoint" "dynamo" {
  count = var.dynamo_db_endpoint_enable ? 1 : 0
  policy              = var.endpoint_policy
  private_dns_enabled = false
  route_table_ids     = var.route_tables
  service_name        = "com.amazonaws.${var.region}.dynamodb"
  vpc_endpoint_type   = "Gateway"
  vpc_id              = var.vpc_id
  tags = {
    Team        = "Alps-DevOps"
    Name        = "${var.environment}-dynamodb-eks"
    Environment = var.environment
    Managed-by  = "Terraform"
    Owner       = var.owner
  }
}

resource "aws_vpc_endpoint" "ec2" {
  count = var.ec2_endpoint_enable ? 1 : 0
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ec2"
  policy              = var.endpoint_policy
  private_dns_enabled = true
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids

  tags = {
    Team        = "Alps-DevOps"
    Name        = "${var.environment}-ec2-eks"
    Environment = var.environment
    Managed-by  = "Terraform"
    Owner       = var.owner
  }
}

resource "aws_vpc_endpoint_security_group_association" "sg_ec2" {
  count = var.ec2_endpoint_enable ? 1 : 0
  vpc_endpoint_id   = aws_vpc_endpoint.ec2[0].id
  security_group_id = var.security_group_id
}

resource "aws_vpc_endpoint" "autoscaling" {
  count = var.autoscaling_endpoint_enable ? 1 : 0
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.autoscaling"
  policy              = var.endpoint_policy
  private_dns_enabled = true
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids

  tags = {
    Team        = "Alps-DevOps"
    Name        = "${var.environment}-autoscaling-eks"
    Environment = var.environment
    Managed-by  = "Terraform"
    Owner       = var.owner
  }
}

resource "aws_vpc_endpoint_security_group_association" "sg_autoscaling" {
  count = var.autoscaling_endpoint_enable ? 1 : 0
  vpc_endpoint_id   = aws_vpc_endpoint.autoscaling[0].id
  security_group_id = var.security_group_id
}

resource "aws_vpc_endpoint" "ecr_api" {
  count = var.ecr_api_endpoint_enable ? 1 : 0
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ecr.api"
  policy              = var.endpoint_policy
  private_dns_enabled = true
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids

  tags = {
    Team        = "Alps-DevOps"
    Name        = "${var.environment}-ecr-api-eks"
    Environment = var.environment
    Managed-by  = "Terraform"
    Owner       = var.owner
  }
}

resource "aws_vpc_endpoint_security_group_association" "sg_ecr_api" {
  count = var.ecr_api_endpoint_enable ? 1 : 0
  vpc_endpoint_id   = aws_vpc_endpoint.ecr_api[0].id
  security_group_id = var.security_group_id
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  count = var.ecr_dkr_endpoint_enable ? 1 : 0
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.ecr.dkr"
  policy              = var.endpoint_policy
  private_dns_enabled = true
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids

  tags = {
    Team        = "Alps-DevOps"
    Name        = "${var.environment}-ecr-dkr-eks"
    Environment = var.environment
    Managed-by  = "Terraform"
    Owner       = var.owner
  }
}

resource "aws_vpc_endpoint_security_group_association" "sg_ecr_dkr" {
  count = var.ecr_dkr_endpoint_enable ? 1 : 0
  vpc_endpoint_id   = aws_vpc_endpoint.ecr_dkr[0].id
  security_group_id = var.security_group_id
}

resource "aws_vpc_endpoint" "elasticloadbalancing" {
  count = var.elasticloadbalancing_endpoint_enable ? 1 : 0
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.elasticloadbalancing"
  policy              = var.endpoint_policy
  private_dns_enabled = true
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids

  tags = {
    Team        = "Alps-DevOps"
    Name        = "${var.environment}-elasticloadbalancing-eks"
    Environment = var.environment
    Managed-by  = "Terraform"
    Owner       = var.owner
  }
}

resource "aws_vpc_endpoint_security_group_association" "sg_elasticloadbalancing" {
  count = var.elasticloadbalancing_endpoint_enable ? 1 : 0
  vpc_endpoint_id   = aws_vpc_endpoint.elasticloadbalancing[0].id
  security_group_id = var.security_group_id
}

resource "aws_vpc_endpoint" "logs" {
  count = var.logs_endpoint_enable ? 1 : 0
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.logs"
  policy              = var.endpoint_policy
  private_dns_enabled = true
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids

  tags = {
    Team        = "Alps-DevOps"
    Name        = "${var.environment}-logs-eks"
    Environment = var.environment
    Managed-by  = "Terraform"
    Owner       = var.owner
  }
}

resource "aws_vpc_endpoint_security_group_association" "sg_logs" {
  count = var.logs_endpoint_enable ? 1 : 0
  vpc_endpoint_id   = aws_vpc_endpoint.logs[0].id
  security_group_id = var.security_group_id
}

resource "aws_vpc_endpoint" "sts" {
  count = var.sts_endpoint_enable ? 1 : 0
  vpc_id              = var.vpc_id
  service_name        = "com.amazonaws.${var.region}.sts"
  policy              = var.endpoint_policy
  private_dns_enabled = true
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.subnet_ids

  tags = {
    Team        = "Alps-DevOps"
    Name        = "${var.environment}-sts-eks"
    Environment = var.environment
    Managed-by  = "Terraform"
    Owner       = var.owner
  }
}

resource "aws_vpc_endpoint_security_group_association" "sg_sts" {
  count = var.sts_endpoint_enable ? 1 : 0
  vpc_endpoint_id   = aws_vpc_endpoint.sts[0].id
  security_group_id = var.security_group_id
}