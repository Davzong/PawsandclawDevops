resource "aws_ecs_cluster" "main" {
  name = "${var.prefix}-cluster"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ecs_service" "service" {
  name = "${var.prefix}-service-${var.name_tag}"
  cluster = aws_ecs_cluster.main.id
  # task_definition = aws_ecs_task_definition.task_definition.arn
  task_definition = var.task_definition.arn
  network_configuration {
    subnets = [var.subnet]
    security_groups = [var.sg]
    assign_public_ip = false
  }
}

