resource "aws_ecs_cluster" "cluster" {
  name = "${var.prefix}-cluster"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ecs_service" "service" {
  name = "${var.prefix}-service-${var.name_tag}"
  cluster = aws_ecs_cluster.cluster.id
  desired_count = 1
  launch_type = "FARGATE"
  task_definition = aws_ecs_task_definition.task_definition.arn
  network_configuration {
    subnets = var.subnet
    security_groups = [var.sg.id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = var.tg_arn
    container_name = "terraform-ecr"
    container_port = 8080
  }
}


resource "aws_ecs_task_definition" "task_definition" {
  family = "pawsandclaws_definition_tf"
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = "1024"
  memory = "3072"
  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn
  container_definitions = jsonencode(
  [
    {
      name = "terraform-ecr"
      image = "${var.repo_url}:latest"
      cpu = 1024
      memory = 3072
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = var.log_group_name
          "awslogs-region"        = "ap-southeast-2"
          "awslogs-stream-prefix" = "ecs"
        }
      }
      portMappings = [
        {
          containerPort = 8080
          hostPort = 8080
        }
      ]
    }
  ]
  )
}
resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = var.log_group_name
  retention_in_days = 7 # Adjust as needed
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole-2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole" 
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}
# resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
#   role       = aws_iam_role.ecs_task_execution_role.name
#   policy_arn = aws_iam_role_policy.ecs_task_execution_policy.arn
# }

resource "aws_iam_role_policy" "ecs_task_execution_policy" {
  name = "ecsTaskExecutionPolicy"
  role = aws_iam_role.ecs_task_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetRepositoryPolicy",
          "ecr:GetAuthorizationToken",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:BatchGetImage",
          "ecs:RegisterTaskDefinition",
          "ecs:DescribeTaskDefinitions",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      }
    ]
  })
}
