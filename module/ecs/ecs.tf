# ecs.tf

resource "aws_ecs_cluster" "main" {
    name = "paws-and-claws-cluster"
}

data "template_file" "cb_app" {
    template = file("./templates/ecs/cb_app.json.tpl")

    vars = {
        app_image      = var.app_image
        app_port       = var.app_port
        fargate_cpu    = var.fargate_cpu
        fargate_memory = var.fargate_memory
        aws_region     = var.aws_region
    }
}

resource "aws_ecs_task_definition" "main" {
    family                   = "paws-and-claws-task-definition"
    # execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
    execution_role_arn       = var.aws_iam_role_ecs_task_execution_role.arn
    network_mode             = "awsvpc"
    requires_compatibilities = ["FARGATE"]
    cpu                      = var.fargate_cpu
    memory                   = var.fargate_memory
    container_definitions    = data.template_file.cb_app.rendered
}

resource "aws_ecs_service" "main" {
    name            = "paws-and-claws-ecs-service"
    cluster         = aws_ecs_cluster.main.id
    task_definition = aws_ecs_task_definition.main.arn
    desired_count   = var.app_count
    launch_type     = "FARGATE"

    network_configuration {
        security_groups  = [var.aws_security_group_ecs_tasks_id]
        subnets          = var.aws_subnet_private.*.id
        assign_public_ip = true
    }

    load_balancer {
        target_group_arn = var.aws_alb_target_group_app_id
        container_name   = "paws-and-claws-ecr"
        container_port   = var.app_port
    }

    depends_on = [var.aws_alb_listener_front_end, var.aws_iam_role_policy_attachment_ecs_task_execution_role_policy_attachment]
}