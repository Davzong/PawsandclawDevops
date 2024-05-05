# variable "prefix" {}

resource "aws_ecs_cluster" "main" {
  name = "${var.prefix}-task"
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_ecs_task_definition" "task_definition" {
  family = "${var.prefix}-task"
  execution_role_arn = "arn:aws:iam::975049907995:role/ecsTaskExecutionRole"
  container_definitions = jsonencode([{
    name = "${var.prefix}"
    image = "975049907995.dkr.ecr.ap-southeast-2.amazonaws.com/pawsandclaws"
    cpu = 1024
    memory = 3072
    portMapping = [
        {
            name = "${var.prefix}-80-tcp"
            containerPort = 80
            protocol = "tcp"
            appProtocol = "http"
        }
    ]
    secrets = [
        {
            name = "MONGO_URL"
            valueFrom = "arn:aws:ssm:ap-southeast-2:975049907995:parameter/MONGO_URI"
        },
        {
            name = "JWT_EXPIRE"
            valueFrom = "arn:aws:ssm:ap-southeast-2:975049907995:parameter/JWT_EXPIRE"
        },
        {
            name = "JWT_SECRET"
            valueFrom = "arn:aws:ssm:ap-southeast-2:975049907995:parameter/JWT_SECRET"
        },
        {
            name = "NEXT_PUBLIC_SHOW_LOGGER"
            valueFrom = "arn:aws:ssm:ap-southeast-2:975049907995:parameter/NEXT_PUBLIC_SHOW_LOGGER"
        }
    ]



  }])
}

resource "aws_ecs_service" "service" {
  name = "${var.prefix}-service"
  cluster = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.task_definition.arn
}