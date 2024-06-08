output "service" {
  value = aws_ecs_service.service
}
output "cluster" {
  value = aws_ecs_cluster.cluster
}
output "cluster_name" {
  value = aws_ecs_cluster.cluster.name
}
output "service_name" {
  value = aws_ecs_service.service.name
}
output "task_definition" {
  value = aws_ecs_task_definition.task_definition
}