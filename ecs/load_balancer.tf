resource "aws_alb" "lb" {

  name = "${var.project_name}-default-lb"
  subnets = [for subnet in var.public_subnet : subnet.id]
  security_groups = [ "${var.security_group}" ]

  tags = {
    Environment = "production"
  }
}


resource "aws_alb_target_group" "alb_target_group" {

  name        = "${var.project_name}-lb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    
  }
}

resource "aws_alb_listener" "lb_listener" {

  load_balancer_arn = "${aws_alb.lb.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb_target_group.id}"
    type             = "forward"
  }
}