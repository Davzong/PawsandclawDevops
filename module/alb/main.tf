resource "aws_alb" "alb" {
    name = "${var.prefix}-alb"
    subnets = var.subnet

  load_balancer_type = "application"
#   security_groups    = [aws_security_group.alb_sg.id]
  security_groups    = var.sg_at_alb
}
