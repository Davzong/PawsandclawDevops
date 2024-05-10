resource "aws_ecs_cluster" "ecs" {
  name = "${var.prefix}-ecs"

# Setting is for cloudwatch
 /* setting {
    name  = "containerInsights"
    value = "enabled"
  } */
}


# Create an ECS task definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "${var.prefix}-ecs-task-definition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  execution_role_arn       = var.execution_role_arn
  container_definitions    = <<TASK_DEFINITION
[
  {
    "name": "${var.prefix}-ecr",
    "image": "${var.ecr_url}:latest",
    "cpu": 1024,
    "memory": 2048,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 3000,
        "hostPort": 3000
      }
    ]
  }
]
TASK_DEFINITION

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "ARM64"
  }
} 

# create ECS service

resource "aws_ecs_service" "ecs_service" {
  name            = "${var.prefix}-ecs-service"
  cluster         = aws_ecs_cluster.ecs.id
  task_definition = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

    network_configuration {
        security_groups  = var.alb_sg_id
        subnets          = var.public_subnet_id
        assign_public_ip = true
    }

    load_balancer {
        target_group_arn = var.alb_target_group
        container_name   = "${var.prefix}-ecr"
        container_port   = 3000
    }
}

