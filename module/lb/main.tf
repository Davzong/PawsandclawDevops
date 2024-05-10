resource "aws_lb" "front_end" {
  name = "${var.prefix}-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = var.sg_front
  subnets = var.public_subnets_id
}
resource "aws_lb_listener" "front_end_lb_listener" {
  load_balancer_arn = aws_lb.front_end.arn
  default_action {
    type = "forward"
    
  }
}