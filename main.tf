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

resource "aws_internet_gateway" "gateway" {
  vpc_id = module.vpc.vpc_id
}
# module "subnet-private-1" {
#   source = "./module/subnet"
#   prefix = var.prefix
#   subnet_name = "private-1"
#   subnet_block = var.subnet[2]
#   vpc_id = module.vpc.vpc_id
#   availability_zones = var.availability_zones[2]
# }
# module "subnet-private-2" {
#   source = "./module/subnet"
#   prefix = var.prefix
#   subnet_name = "private-2"
#   subnet_block = var.subnet[3]
#   vpc_id = module.vpc.vpc_id
#   availability_zones = var.availability_zones[2]
# }
module "ecs" {
  source = "./module/ecs"
  prefix = var.prefix
}
module "sg" {
  source = "./module/sg"
  vpc_id = module.vpc.vpc_id
  prefix = var.prefix
}
module "alb" {
  source = "./module/alb"
  subnet = [module.subnet-public-1.id,module.subnet-public-2.id]
  prefix = var.prefix
  sg_at_alb = [module.sg.sg_alb.id]
}
