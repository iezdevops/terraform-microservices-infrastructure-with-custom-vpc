resource "aws_network_interface" "wearslot" {

  subnet_id       = var.private_subnet[0].id
  security_groups = ["${var.security_group.id}"]
  private_ips = [
    "${var.private_subnet[0].cidr_block}",
    "${var.private_subnet[1].cidr_block}"
  ]

  tags = {
    Name = "primary_network_interface"
  }
}
