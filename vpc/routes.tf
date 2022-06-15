resource "aws_route_table" "wearslot" {
  
  vpc_id = aws_vpc.wearslot.id
}

# Create a new route table for the private subnets
# And make it route non-local traffic through the NAT gateway to the internet
resource "aws_route_table" "private" {
  count  = "${var.az_count}"
  vpc_id = "${aws_vpc.wearslot.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.wearslot.*.id, count.index)}"
  }
}

resource "aws_route" "wearslot" {
  
  route_table_id = aws_route_table.wearslot.id
  gateway_id = aws_internet_gateway.wearslot.id
  destination_cidr_block = "0.0.0.0/0"

}