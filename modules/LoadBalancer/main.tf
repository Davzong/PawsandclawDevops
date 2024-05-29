// Create the ALB
resource "aws_lb" "lb" {
    name = "${var.env_prefix}-lb"
    internal = false
    load_balancer_type = "application"
    subnets = var.subnet_ids_list
    security_groups    = [var.load_balancer_security_group_id] 
    
}


// Create the Prod target group
resource "aws_lb_target_group" "prod_tg" {
  name     = "prod-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.prod_vpc_id
  target_type = "ip"
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 30
    matcher             = "404"
    path                = "/status"
    port                = "3000"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 3
  }
}


// Create the Uat target group
resource "aws_lb_target_group" "uat_tg" {
  name     = "uat-tg"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = var.prod_vpc_id
  target_type = "ip"
  
  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 30
    matcher             = "404"
    path                = "/status"
    port                = "3000"
    protocol            = "HTTP"
    timeout             = 5
    unhealthy_threshold = 3
  }
}



// Create the ALB listener
resource "aws_lb_listener" "my_listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = 80
  protocol          = "HTTP"
  # Add other listener configuration as needed
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.prod_tg.arn
  }
}



// forward the traffic to UAT based on the hostname
resource "aws_lb_listener_rule" "rule_2" {
  listener_arn = aws_lb_listener.my_listener.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.uat_tg.arn
  }

  condition {
    host_header {
      values = ["uat.yuanpawsnclawshotel.com"]
    }
  }
}
