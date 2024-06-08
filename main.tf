provider "aws" {
  region = var.region
}
module "vpc" {
  source = "./terraform-module/vpc"
  prefix = var.prefix
  cidr_block = var.vpc_cidr
}
module "public-subnet-1" {
  source = "./terraform-module/subnet"
  prefix = var.prefix
  subnet_name = "${var.prefix}-public-subnet2"
  subnet_block = var.subnet[0]
  availability_zones = var.availability_zones[0]
  vpc_id = module.vpc.vpc_id
}
module "public-subnet-2" {
  source = "./terraform-module/subnet"
  prefix = var.prefix
  subnet_name = "${var.prefix}-public-subnet-2"
  subnet_block = var.subnet[1]
  availability_zones = var.availability_zones[1]
  vpc_id = module.vpc.vpc_id
}
module "ecs" {
  source = "./terraform-module/ecs"
  prefix = var.prefix
  subnet = [module.public-subnet-1.id,module.public-subnet-2.id]
  name_tag = ""
  sg = module.sg
  tg_arn = module.alb.tg_arn
  repo_url = module.ecr.repo_url
}


module "alb" {
  source = "./terraform-module/alb"
  prefix = var.prefix
  subnets = [module.public-subnet-1.id,module.public-subnet-2.id]
  sg_at_alb = [module.sg.id]
  vpc_id = module.vpc.vpc_id
}

module "sg" {
  source = "./terraform-module/sg"
  vpc_id = module.vpc.vpc_id
  prefix = var.prefix
}
module "public-network" {
  source = "./terraform-module/public-network"
  prefix = var.prefix
  subnet_ids = [module.public-subnet-1.id,module.public-subnet-2.id]
  vpc_id = module.vpc.vpc_id
}
module "ecr" {
  source = "./terraform-module/ecr"
  prefix = var.prefix
}

output "aws_names" {
  value = [
    "ECR Repo name: ${module.ecr.repository_name}",
    "Service name: ${module.ecs.service_name}",
    "ECS cluster name: ${module.ecs.cluster_name}"
    ]
}

# output "task_definition" {
#   # value = "${module.ecs.task_definition}"
#   # value = jsondecode(jsonencode(module.ecs.task_definition))
#   value = module.ecs.task_definition
# }
# output "container_definitions" {
#   value = jsondecode(module.ecs.task_definition.container_definitions)

# }