output "lb_sg_id" {
  value = aws_security_group.lb_sg.id

}
output "ecs_sg_id" {
  value = aws_security_group.ecs_sg.id
}

