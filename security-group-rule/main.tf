resource "aws_security_group_rule" "ingress_cidr_blocks_rule" {
  count = length(var.ingress_cidr_blocks_map_list) > 0 ? length(var.ingress_cidr_blocks_map_list) : 0
  type              = "ingress"
  from_port         = lookup(var.ingress_cidr_blocks_map_list[count.index], "from_port")
  to_port           = lookup(var.ingress_cidr_blocks_map_list[count.index], "to_port")
  protocol          = lookup(var.ingress_cidr_blocks_map_list[count.index], "protocol")
  description       = lookup(var.ingress_cidr_blocks_map_list[count.index], "description")
  cidr_blocks       = lookup(var.ingress_cidr_blocks_map_list[count.index], "cidr_blocks")
  security_group_id = var.security_group_id
}

resource "aws_security_group_rule" "ingress_source_sg_rule" {
  type  = "ingress"
  count = var.source_security_group_id != "" ? length(var.ingress_sg_map_list) : 0
  from_port                = lookup(var.ingress_sg_map_list[count.index], "from_port")
  to_port                  = lookup(var.ingress_sg_map_list[count.index], "to_port")
  protocol                 = lookup(var.ingress_sg_map_list[count.index], "protocol")
  description              = lookup(var.ingress_sg_map_list[count.index], "description")
  source_security_group_id = lookup(var.ingress_sg_map_list[count.index], "source_security_group_id")
  security_group_id        = var.security_group_id
}