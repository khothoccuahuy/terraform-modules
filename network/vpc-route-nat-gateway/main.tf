resource "aws_route" "nat_gateway" {
  route_table_id         = var.route_table_id
  nat_gateway_id         = var.nat_gateway_id
  destination_cidr_block = var.destination_cidr_block
}