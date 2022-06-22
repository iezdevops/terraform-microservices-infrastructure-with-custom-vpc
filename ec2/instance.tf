resource "aws_instance" "wearslot" {

  ami           = "ami-09d56f8956ab235b3"
  instance_type = "t3.micro"
  tags = {
    Name = var.instance_name
  }
  key_name = "wearslot"
  # vpc_security_group_ids = ["sg-0da231a8412d93ecf"] #[var.security_group]
  associate_public_ip_address = true
  security_groups             = ["${var.security_group}"]
  subnet_id                   = var.public_subnet[0].id

  # network_interface {
  #   network_interface_id = aws_network_interface.wearslot.id
  #   device_index         = 0
  # }

  # provisioner "remote-exec" {
  #   inline = ["chmod 400 ~/${var.key_name}.pem"]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.key_name}.pem")
      host        = self.public_ip
    }
  # }

}
