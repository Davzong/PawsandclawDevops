resource "aws_lb" "alb" {
  name               = "${var.prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  #security_groups    = [aws_security_group.alb_sg.id]
  security_groups    = var.alb_sg_id
  subnets            = var.public_subnet_id
}

resource "aws_alb_target_group" "pawsnclaws_tg" {
    name        = "${var.prefix}-target-group"
    port        = 80
    protocol    = "HTTP"
    vpc_id      = var.vpc_id
    target_type = "ip"

    health_check {
        healthy_threshold   = "3"
        interval            = "30"
        protocol            = "HTTP"
        matcher             = "200"
        timeout             = "3"
        path                = var.health_check_path
        unhealthy_threshold = "2"
    }
}

# Redirect all from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.id
  port = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.pawsnclaws_tg.id
    type             = "forward"
  }
}