resource "aws_lb" "alb" {
  name               = "pawsandclaws-app-load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_sg_id]
  subnets            = var.lb_subnet_id

  enable_deletion_protection = false

  tags = merge(
    {
      "Name" : "alb-${var.workspace}"
  }, var.default_tags)
}

resource "aws_alb_target_group" "main_alb_tg" {
  name        = "paws-app-alb-target-group"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 30
    matcher             = "404"
    path                = var.health_check
    port                = "3000"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 3
  }
}

resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.main_alb_tg.arn
    type             = "forward"
  }

  
}

resource "aws_alb_listener" "listener_https" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"



  default_action {
    target_group_arn = aws_alb_target_group.main_alb_tg.arn
    type             = "forward"
  }

  depends_on = [aws_alb_target_group.main_alb_tg]
}


