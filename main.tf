terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-2"
}

module "vpc" {
  source           = "./module/vpc"
  prefix           = var.prefix
  cidr_block       = var.cidr_block
  public_subnet_id = module.subnet.public_subnet_id
}

module "subnet" {
  source             = "./module/subnet"
  prefix             = var.prefix
  availability_zones = var.availability_zones
  vpc_id             = module.vpc.vpc_id
  cidr_block         = var.cidr_block
}


module "sg" {
  source = "./module/sg"
  prefix = var.prefix
  vpc_id = module.vpc.vpc_id
}


module "alb" {
  source           = "./module/alb"
  prefix           = var.prefix
  alb_sg_id        = [module.sg.alb_sg_id]
  public_subnet_id = module.subnet.public_subnet_id
  vpc_id = module.vpc.vpc_id
}


module "iam" {
  source           = "./module/iam"
  prefix           = var.prefix
}

module "ecr" {
  source          = "./module/ecr"
  prefix           = var.prefix
}

module "ecs" {
  source          = "./module/ecs" 
  prefix= var.prefix
  app_count = var.app_count
  public_subnet_id = module.subnet.public_subnet_id
  alb_sg_id = [module.sg.alb_sg_id]
  alb_target_group = module.alb.target_group_arn
  ecr_url = module.ecr.ecr_url 
  execution_role_arn = module.iam.ecs_execution_role_arn
}



