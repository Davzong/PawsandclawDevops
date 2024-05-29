output "aws_security_group_lb_id" {
    value = aws_security_group.lb.id
}

output "aws_security_group_ecs_tasks_id" {
    value = aws_security_group.ecs_tasks.id
}