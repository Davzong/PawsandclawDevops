output "alb_hostname" {
  value = aws_alb.main.dns_name
}

output "aws_alb_target_group_app_id" {
  value = aws_alb_target_group.app.id
}

output "aws_alb_listener_front_end" {
  value = aws_alb_listener.front_end
}
