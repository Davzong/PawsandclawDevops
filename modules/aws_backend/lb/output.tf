output "main_alb_tg_id" {
  value = aws_alb_target_group.main_alb_tg.arn
}

output "alb_listener_http" {
  value = aws_alb_listener.listener_http
}

output "alburl" {
  value = aws_lb.alb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.alb.zone_id
}