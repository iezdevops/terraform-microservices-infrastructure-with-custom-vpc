# Internet gateway for public subnet traffic
resource "aws_internet_gateway" "wearslot" {

  vpc_id = aws_vpc.wearslot.id
}



# Internet gateway for private subnet 
# This requires an elastic ip depending on the public gateway
resource "aws_nat_gateway" "wearslot" {
  
  count = var.az_count
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  allocation_id = "${element(aws_eip.wearslot.*.id, count.index)}"
}
