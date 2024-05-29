provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region = var.aws_region
}

module "alb" {
    source = "./module/alb"
    health_check_path = var.health_check_path
    aws_subnet_public = module.network.aws_subnet_public
    aws_security_group_lb_id = module.security.aws_security_group_lb_id
    aws_vpc_id = module.network.aws_vpc_id
}

module "autoscaling" {
    source = "./module/autoscaling"
    aws_ecs_cluster_main = module.ecs.aws_ecs_cluster_main
    aws_ecs_service_main = module.ecs.aws_ecs_service_main
    aws_iam_role_ecs_auto_scale_role = module.iam.aws_iam_role_ecs_auto_scale_role
}

module "ecr" {
    source = "./module/ecr"
}

module "ecs" {
    source = "./module/ecs"
    app_image = var.app_image
    app_port = var.app_port
    fargate_cpu = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region = var.aws_region
    app_count = var.app_count
    aws_iam_role_ecs_auto_scale_role = module.iam.aws_iam_role_ecs_auto_scale_role
    aws_subnet_private = module.network.aws_subnet_private
    aws_security_group_ecs_tasks_id = module.security.aws_security_group_ecs_tasks_id
    aws_alb_target_group_app_id = module.alb.aws_alb_target_group_app_id
    aws_alb_listener_front_end = module.alb.aws_alb_listener_front_end
    aws_iam_role_policy_attachment_ecs_task_execution_role_policy_attachment = module.iam.aws_iam_role_policy_attachment_ecs_task_execution_role_policy_attachment
    aws_iam_role_ecs_task_execution_role = module.iam.aws_iam_role_ecs_task_execution_role
}

module "iam" {
    source = "./module/iam"
    ecs_auto_scale_role_name = var.ecs_auto_scale_role_name
}

module "network" {
    source = "./module/network"
    az_count = var.az_count
}

module "security" {
    source = "./module/security"
 
    app_port = var.app_port
    aws_vpc_id = module.network.aws_vpc_id
}