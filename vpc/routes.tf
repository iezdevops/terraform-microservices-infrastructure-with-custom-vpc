resource "aws_route_table" "public" {

  name = "${var.project_name}-pub1-route-table"
  vpc_id = aws_vpc.vpc.id

  # route {
  #   cidr_block = "0.0.0.0/0"
  #   gateway_id = aws_internet_gateway.internet-gateway.id
  # }
}

# Create a new route table for the private subnets
# And make it route non-local traffic through the NAT gateway to the internet
resource "aws_route_table" "private" {

  count  = var.az_count
  name = "${var.project_name}-prv${count.index}-route-table"
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.nat_gateway.*.id, count.index)
  }
}

resource "aws_route" "rs_route" {

  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.internet_gateway.id
  destination_cidr_block = "0.0.0.0/0"

}


resource "aws_route_table_association" "route-table-assoc-pubs1" {

  count          = var.az_count
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}
