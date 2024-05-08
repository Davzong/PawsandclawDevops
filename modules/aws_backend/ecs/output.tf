output "ecs_arn" {
  value = aws_ecs_cluster.main_ecs.arn
}

output "main_ecs_name" {
  value = aws_ecs_cluster.main_ecs.name
}

output "main_ecs_service_name" {
  value = aws_ecs_service.main_ecs_service.name
}
