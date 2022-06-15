resource "aws_alb" "alb" {

  name = "wslt-default-lb"
  subnets = [for subnet in var.subnets : subnet.id]
  security_groups = [ "${var.security_group}" ]

  tags = {
    Environment = "production"
  }
}


resource "aws_alb_target_group" "wearslot" {

  name        = "wslt-default-lb-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
}
