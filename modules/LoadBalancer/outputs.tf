output "lb_tg" {
    value = aws_lb_target_group.uat_tg
}

output "prod_lb_tg" {
    value = aws_lb_target_group.prod_tg
}


// below for the front end use
output "alb_info" {
    value = aws_lb.lb
}