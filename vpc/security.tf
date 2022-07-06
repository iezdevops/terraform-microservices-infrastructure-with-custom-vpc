resource "aws_security_group" "security_group" {
  name        = "${var.project_name}-vpc-ssh-security"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    to_port     = 22
    from_port   = 22
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    description = "Enabling port for ssh connection"
  }

  egress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Traffic to the ECS Cluster should only come from the ALB
resource "aws_security_group" "ecs_tasks" {
  name        = "${var.project_name}-ecs-tasks-security"
  description = "allow inbound access from the ALB only"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    protocol        = "tcp"
    from_port       = var.app_port
    to_port         = var.app_port
    security_groups = ["${aws_security_group.security_group.id}"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
