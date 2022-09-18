resource "aws_security_group" "security_group" {
  name        = "${var.project_name}-vpc-ssh-security"
  description = "ELB allow traffic from anywhere"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    description = "Enabling port for internet connection"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # lifecycle {
  #   force_destroy = true
  # }
}

resource "aws_security_group" "security_group_for_https" {
  name        = "${var.project_name}-vpc-https-security"
  description = "ELB allow traffic from anywhere on https "
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    description = "Enabling port for internet connection"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # lifecycle {
  #   force_destroy = true
  # }
}


# Traffic to the ECS Cluster should only come from the ALB
resource "aws_security_group" "ecs_sg" {
  name        = "${var.project_name}-ecs-sg"
  description = "allow inbound access from the ALB only"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = var.container_port
    to_port         = var.container_port
    security_groups = ["${aws_security_group.security_group.id}"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
