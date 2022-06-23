resource "aws_network_interface" "network_interface" {

  subnet_id       = var.private_subnet[0].id
  security_groups = ["${var.security_group}"]

  # Expecting cidrhosts
  # private_ips = [
  #   
  # ]

  tags = {
    Name = "primary_network_interface"
  }
}
