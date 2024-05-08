resource "aws_ecs_task_definition" "main_ecs_task_def" {
  family                   = "apptask-${var.workspace}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  execution_role_arn       = var.ecsTaskExecutionRole_arn

  container_definitions = <<DEFINITION
[
  {
    "name": "${var.container_name}",
    "image": "${var.default_backend_image}:latest",
    "essential": true,
    "portMappings": [
      {
        "protocol": "tcp",
        "containerPort": ${var.container_port},
        "hostPort": ${var.container_port}
      }
    ],
    "environment": [
      {
        "name": "PORT",
        "value": "${var.container_port}"
      },
      {
        "name": "HEALTHCHECK",
        "value": "${var.health_check}"
      },
      {
        "name": "ENABLE_LOGGING",
        "value": "false"
      },
      {
        "name": "PRODUCT",
        "value": "app"
      },
      {
        "name": "ENVIRONMENT",
        "value": "${var.workspace}"
      }
    ],  
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "/fargate/service/app-${var.workspace}",
        "awslogs-region": "${var.region}",
        "awslogs-stream-prefix": "ecs"
      }
    }
  }
]
DEFINITION

  tags = merge(
    {
      "Name" : "app-ecs-taskdef-${var.workspace}"
  }, var.default_tags)
}

