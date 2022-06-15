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

# Traffic to the ECS Cluster should only come from the ALB
resource "aws_security_group" "wearslot_ecs_tasks" {
  name        = "wearslot-ecs-tasks"
  description = "allow inbound access from the ALB only"
  vpc_id      = aws_vpc.wearslot.id

  ingress {
    protocol        = "tcp"
    from_port       = var.app_port
    to_port         = var.app_port
    security_groups = ["${aws_security_group.wearslot.id}"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
