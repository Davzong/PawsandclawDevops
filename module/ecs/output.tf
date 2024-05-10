output "service" {
  value = aws_ecs_service.service
}
output "cluster" {
  value = aws_ecs_cluster.main
}
