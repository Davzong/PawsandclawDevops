# output the ECS info
output "ECS_info" {
    value = aws_ecs_service.ecs_service
}

output "ecs_taskdefinition" {
    value = aws_ecs_task_definition.ecs_task
}