resource "aws_lb" "lb" {
  name = "${var.prefix}-alb"
  subnets = var.subnets

  load_balancer_type = "application"
  security_groups    = var.sg_at_alb
  tags = {
    Environment = "Production"
  }
}
resource "aws_lb_target_group" "tg" {
  name     = "tg"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "ip"
  health_check {
    interval            = 30
    path                = "/api/health-check"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200-499"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}