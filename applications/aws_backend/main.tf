terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

//s3 backend
terraform {
  backend "s3" {
    bucket         = "pawsandclaws-uat-tf-backend-bucket"
    key            = "pawsandclaws-uat-tf-backend.tfstate"
    region         = "ap-southeast-2"
    encrypt        = true
    dynamodb_table = "pawsandclaws-UAT-tf-backend-lock"
  }
}


module "aws_ecr" {
  source    = "../../modules/aws/back_end/ecr"
  workspace = lookup(var.workspace, terraform.workspace)

}

module "aws_ecs" {
  source                   = "../../modules/aws/back_end/ecs"
  ecs_sg_id                = module.aws_security_group.ecs_sg_id
  main_alb_tg_id           = module.aws_lb.main_alb_tg_id
  alb_listener_http        = module.aws_lb.alb_listener_http
  ecsTaskExecutionRole_arn = module.aws_role.ecsTaskExecutionRole_arn
  default_backend_image    = module.aws_ecr.default_backend_image
  ecs_subnet_id            = module.aws_vpc.ecs_subnet_id
  replicas                 = lookup(var.replicas, terraform.workspace)
  region                   = lookup(var.region, terraform.workspace)
  health_check             = lookup(var.health_check, terraform.workspace)
  container_port           = lookup(var.container_port, terraform.workspace)
  container_name           = lookup(var.container_name, terraform.workspace)
  fargate_memory           = lookup(var.fargate_memory, terraform.workspace)
  fargate_cpu              = lookup(var.fargate_cpu, terraform.workspace)
  default_tags             = lookup(var.default_tags, terraform.workspace)
  #s3_env_arn               = lookup(var.s3_env_arn, terraform.workspace)
  workspace = lookup(var.workspace, terraform.workspace)
}

module "aws_vpc" {
  source                = "../../modules/aws/back_end/vpc"
  vpc_cidr              = lookup(var.vpc_cidr, terraform.workspace)
  az_count              = lookup(var.az_count, terraform.workspace)
  workspace             = lookup(var.workspace, terraform.workspace)
  container_name        = "my-container"
  health_check          = "/status"
  fargate_cpu           = 1024
  replicas              = 2
  default_backend_image = "your-backend-image:latest"
  container_port        = 8080
  alb_ssl_cert_arn      = "arn:aws:acm:region:account:certificate/certificate-id"
  fargate_memory        = 2048
}

module "aws_lb" {
  source         = "../../modules/aws/back_end/lb"
  vpc_id         = module.aws_vpc.vpc_id
  lb_sg_id       = module.aws_security_group.lb_sg_id
  lb_subnet_id   = module.aws_vpc.lb_subnet_id
  health_check   = lookup(var.health_check, terraform.workspace)
  container_port = lookup(var.container_port, terraform.workspace)

  workspace = lookup(var.workspace, terraform.workspace)
}

module "aws_security_group" {
  source                = "../../modules/aws/back_end/security_group"
  vpc_id                = module.aws_vpc.vpc_id
  workspace             = lookup(var.workspace, terraform.workspace)
  replicas              = var.replicas
  container_name        = var.container_name
  default_backend_image = "533247146470.dkr.ecr.ap-southeast-2.amazonaws.com/uat-paws-and-claws-container"
  region                = lookup(var.region, terraform.workspace)
  health_check          = var.health_check
}

module "aws_cloudwatch" {
  source                        = "../../modules/aws/back_end/cloudwatch"
  main_ecs_name                 = module.aws_ecs.main_ecs_name
  main_ecs_service_name         = module.aws_ecs.main_ecs_service_name
  ecs_as_cpu_high_threshold_per = lookup(var.ecs_as_cpu_high_threshold_per, terraform.workspace)
  ecs_as_cpu_low_threshold_per  = lookup(var.ecs_as_cpu_low_threshold_per, terraform.workspace)
  app_asg_up_arn                = var.app_asg_up_arn
  app_asg_down_arn              = var.app_asg_down_arn
  workspace                     = lookup(var.workspace, terraform.workspace)

}


module "aws_role" {
  source    = "../../modules/aws/back_end/role"
  ecs_arn   = module.aws_ecs.ecs_arn
  workspace = lookup(var.workspace, terraform.workspace)

}

output "alburl" {
  value = module.aws_lb.alburl
}


output "default_backend_image" {
  value = module.aws_ecr.default_backend_image
}

