resource "aws_network_interface" "wearslot" {

  count = 2

  subnet_id   = "${var.private_subnet[0].id}"
  security_groups = ["${var.security_group.id}"]
  private_ips = ["${var.private_subnet[count.index].cidr_block}"]

  tags = {
    Name = "primary_network_interface"
  }
}