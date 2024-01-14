resource "aws_route" "route_peering_connection" {
  route_table_id            = var.route_table_id
  vpc_peering_connection_id = var.vpc_peering_connection_id
  destination_cidr_block    = var.destination_cidr_block
}