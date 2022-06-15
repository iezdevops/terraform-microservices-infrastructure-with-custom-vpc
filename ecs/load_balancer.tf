resource "aws_alb" "wearslot" {

  name = "wslt-default-lb"
  subnets = [for subnet in var.public_subnet : subnet.id]
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

resource "aws_alb_listener" "wearslot" {

  load_balancer_arn = "${aws_alb.wearslot.id}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.wearslot.id}"
    type             = "forward"
  }
}