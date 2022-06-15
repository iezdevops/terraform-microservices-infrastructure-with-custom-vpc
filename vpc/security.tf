resource "aws_security_group" "wearslot" {

  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.wearslot.id

  ingress {
    to_port     = 22
    from_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    description = "Enabling port for ssh connection"
  }

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    description = "Enabling port for http connection"
  }

  egress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
