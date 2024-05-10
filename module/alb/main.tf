resource "aws_alb" "alb" {
    name = "${var.prefix}-alb"
    subnets = var.subnet

  load_balancer_type = "application"
  security_groups    = var.sg_at_alb
  
}
