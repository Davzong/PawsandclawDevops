output "sg_alb" {
  value = aws_security_group.alb_sg
}
output "ecs_sg" {
  value = aws_security_group.ecs_sg
}
output "id" {
  value = aws_security_group.ecs_sg.id
}