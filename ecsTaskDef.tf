resource "aws_ecs_task_definition" "app_task" {
  family                   = "my-app-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"  # Adjust as necessary
  memory                   = "512"  # Adjust as necessary
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  container_definitions    = jsonencode([
    {
      name      = "my-app"
      image     = "${aws_ecr_repository.app_repository.repository_url}:latest"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
      environment = [
        {
          name  = "ENV_VAR_NAME"
          value = "Value"
        }
      ]
      secrets = [
        {
          name      = "SECRET_ENV_VAR"
          valueFrom = "${aws_ssm_parameter.secret_parameter.arn}"
        }
      ]
    }
  ])
}
