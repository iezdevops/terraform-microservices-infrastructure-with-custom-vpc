resource "aws_security_group" "rds_security_group" {
  name        = "${var.project_name}-database-security-group"
  description = "Allow inbound traffic from anywhere"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    description = "Enabling traffic from anywhere"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
