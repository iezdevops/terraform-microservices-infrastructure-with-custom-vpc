resource "aws_instance" "wearslot" {

  ami           = "ami-09d56f8956ab235b3"
  instance_type = "t3.micro"
  tags = {
    Name = var.instance_name
  }
  key_name = "wearslot"
  vpc_security_group_ids = [ var.security_group ]

  connection {
    type        = "ssh"
    host        = self.public_id
    user        = "wearslot"
    private_key = file("/wearslot.pem")
    timeout     = "5m"
  }

}