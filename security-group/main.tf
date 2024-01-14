resource "aws_security_group" "sg" {
  name        = var.security_group_name
  description = var.security_group_description
  vpc_id      = var.vpc_id

  tags = merge({
    Team        = "Alps-DevOps"
    Name        = var.security_group_name
    Environment = var.environment
    Terraform   = "true"
    Owner       = var.owner
  }, var.tags)
}

resource "aws_security_group_rule" "ingress_cidr_blocks_rule" {
  count = length(var.ingress_cidr_blocks_map_list) > 0 ? length(var.ingress_cidr_blocks_map_list) : 0
  type  = "ingress"

  from_port   = lookup(var.ingress_cidr_blocks_map_list[count.index], "from_port")
  to_port     = lookup(var.ingress_cidr_blocks_map_list[count.index], "to_port")
  protocol    = lookup(var.ingress_cidr_blocks_map_list[count.index], "protocol")
  cidr_blocks = lookup(var.ingress_cidr_blocks_map_list[count.index], "cidr_blocks")

  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "ingress_source_sg_rule" {
  type  = "ingress"
  count = length(var.ingress_sg_map_list) > 0 ? length(var.ingress_sg_map_list) : 0

  from_port                = lookup(var.ingress_sg_map_list[count.index], "from_port")
  to_port                  = lookup(var.ingress_sg_map_list[count.index], "to_port")
  protocol                 = lookup(var.ingress_sg_map_list[count.index], "protocol")
  source_security_group_id = lookup(var.ingress_sg_map_list[count.index], "source_security_group_id")
  security_group_id        = aws_security_group.sg.id
}

resource "aws_security_group_rule" "ingress_self_source_sg_rule" {
  type  = "ingress"
  count = length(var.ingress_self_sg_map_list) > 0 ? length(var.ingress_self_sg_map_list) : 0

  from_port                = lookup(var.ingress_self_sg_map_list[count.index], "from_port")
  to_port                  = lookup(var.ingress_self_sg_map_list[count.index], "to_port")
  protocol                 = lookup(var.ingress_self_sg_map_list[count.index], "protocol")
  source_security_group_id = aws_security_group.sg.id
  security_group_id        = aws_security_group.sg.id
}

resource "aws_security_group_rule" "egress_rule" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg.id
}



