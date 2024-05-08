resource "aws_ecs_service" "main_ecs_service" {
  name            = "Pawsandclaws-${var.workspace}"
  cluster         = aws_ecs_cluster.main_ecs.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.main_ecs_task_def.arn
  desired_count   = var.replicas

  network_configuration {
    security_groups  = [var.ecs_sg_id]
    subnets          = var.ecs_subnet_id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.main_alb_tg_id
    container_name   = var.container_name
    container_port   = var.container_port
  }

  enable_ecs_managed_tags = true
  propagate_tags          = "SERVICE"


  depends_on = [var.alb_listener_http]

  lifecycle {
    ignore_changes = [task_definition]
  }

  tags = merge(
    {
      "Name" : "ECS-service-${var.workspace}"
  }, var.default_tags)
}

