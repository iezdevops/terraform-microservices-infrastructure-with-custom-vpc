resource "aws_alb" "lb" {
  name            = "${var.project_name}-default-lb"
  subnets         = [for subnet in var.subnets : subnet]
  security_groups = ["${aws_security_group.security_group.id}", "${aws_security_group.security_group_for_https.id}"]
}


resource "aws_alb_target_group" "alb_target_group" {
  name        = "${var.project_name}-lb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"
  depends_on = [
    aws_alb.lb
  ]

  health_check {
    path     = "/"
    protocol = "HTTP"
    matcher  = "200"
  }
}

resource "aws_alb_listener" "lb_listener" {

  load_balancer_arn = "${aws_alb.lb.id}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb_target_group.id}"
    type             = "forward"
  }
}



# resource "aws_alb_listener_certificate" "https_lb_certificate" {
#   listener_arn    = aws_alb_listener.lb_https_listener.arn
#   certificate_arn = aws_acm_certificate.myapp.arn
# }
