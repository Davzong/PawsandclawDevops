provider "aws" {
  region = var.region
}
module "vpc" {
  source = "./module/vpc"
  prefix = var.prefix
  cidr_block = var.vpc_cidr
}

module "subnet-public-1" {
  source = "./module/subnet"
  prefix = var.prefix
  subnet_name = "public-1"
  subnet_block = var.subnet[0]
  vpc_id = module.vpc.vpc_id
  availability_zones = var.availability_zones[0]
  
}
module "subnet-public-2" {
  source = "./module/subnet"
  prefix = var.prefix
  subnet_name = "public-2"
  subnet_block = var.subnet[1]
  vpc_id = module.vpc.vpc_id
  availability_zones = var.availability_zones[1]
}

module "subnet-private-1" {
  source = "./module/subnet"
  prefix = var.prefix
  subnet_name = "private-1"
  subnet_block = var.subnet[2]
  vpc_id = module.vpc.vpc_id
  availability_zones = var.availability_zones[0]
}
module "subnet-private-2" {
  source = "./module/subnet"
  prefix = var.prefix
  subnet_name = "private-2"
  subnet_block = var.subnet[3]
  vpc_id = module.vpc.vpc_id
  availability_zones = var.availability_zones[1]
}
resource "aws_ecs_task_definition" "task_definition" {
  family = "${var.prefix}-task"
  execution_role_arn = "arn:aws:iam::975049907995:role/ecsTaskExecutionRole"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = "1024"
  memory = "3072"
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

module "ecs-1" {
  source = "./module/ecs"
  prefix = var.prefix
  subnet = module.subnet-private-1.id
  sg = module.sg.ecs_sg.id
  task_definition = aws_ecs_task_definition.task_definition
  name_tag = "1"
}
module "ecs-2" {
  source = "./module/ecs"
  prefix = var.prefix
  subnet = module.subnet-private-2.id
  sg = module.sg.ecs_sg.id
  task_definition = aws_ecs_task_definition.task_definition
  name_tag = "2"
}
module "sg" {
  source = "./module/sg"
  vpc_id = module.vpc.vpc_id
  prefix = var.prefix
}
module "public-network" {
  source = "./module/public-network"
  vpc_id = module.vpc.vpc_id
  subnet_ids = [module.subnet-public-1.id,module.subnet-public-2.id]
  prefix = var.prefix
}
module "private-network-1" {
  source = "./module/private-network"
  public_subnet_id = module.subnet-public-1.id
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = [ module.subnet-private-1.id ]
  prefix = var.prefix
  num = 1
}

module "private-network-2" {
  source = "./module/private-network"
  public_subnet_id = module.subnet-public-2.id
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = [ module.subnet-private-2.id ]
  prefix = var.prefix
  num = 2
}

module "alb" {
  source = "./module/alb"
  subnet = [module.subnet-public-1.id,module.subnet-public-2.id]
  prefix = var.prefix
  sg_at_alb = [module.sg.sg_alb.id]
}
module "clouwatch-1" {
  source = "./module/cloudwatch"
  prefix = var.prefix
  app_cluster = module.ecs-1.cluster
  app_service = module.ecs-1.service
}
module "clouwatch-2" {
  source = "./module/cloudwatch"
  prefix = var.prefix
  app_cluster = module.ecs-2.cluster
  app_service = module.ecs-2.service
}
module "iam" {
  source = "./module/IAM"
  prefix = var.prefix
}