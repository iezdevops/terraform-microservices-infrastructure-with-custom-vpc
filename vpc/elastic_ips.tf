# Create an EIP for a NAT gateway with for each private subnet to get internet connectivity
resource "aws_eip" "wearslot" {
  
  count      = "${var.az_count}"
  vpc        = true
  depends_on = [aws_internet_gateway.wearslot]
}