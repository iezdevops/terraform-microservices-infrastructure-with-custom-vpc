# Internet gateway for public subnet traffic
resource "aws_internet_gateway" "internet_gateway" {

  vpc_id = aws_vpc.vpc.id
}



# Nat gateway for public subnet 
# This requires an elastic ip depending on the public gateway
resource "aws_nat_gateway" "nat_gateway" {
  
  count = var.az_count
  subnet_id = "${element(aws_subnet.public.*.id, count.index)}"
  allocation_id = "${element(aws_eip.eip.*.id, count.index)}"
}
