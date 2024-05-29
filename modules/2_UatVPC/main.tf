# Uat IaC 

// Create the UAT VPC
module "Uat_vpc1" {
    source = "../vpc"
    vpc_cidr_block = var.vpc_cidr_block
    env_prefix = var.env_prefix

}

// Create the UAT subnets
module "Uat_subnets" {
    source = "../subnet"
    vpc_id = module.Uat_vpc1.vpc.id
    subnet_cidr_block = var.subnet_cidr_block
    env_prefix = var.env_prefix
    avail_zone = var.avail_zone
    subnet_names = var.subnet_names

}

// Create the UAT Internet Gateway
module "Uat_igw" {
    source = "../InternetGateway"
    vpc_id = module.Uat_vpc1.vpc.id
    env_prefix = var.env_prefix
}

// Route the UAT network
module "Uat_rtb" {
    source = "../RouteTable"
    vpc_id = module.Uat_vpc1.vpc.id
    gateway_id = module.Uat_igw.igw.id
    env_prefix = var.env_prefix
    vpc_peering_id = var.vpc_peering_id
    peering_vpc_cidr = var.peering_vpc_cidr
}

// Associate the subet to the Network
module "Uat_rtb_association" {
    source = "../RouteTBAssociation"
    subnet_ids_list = module.Uat_subnets.subnet_ids_list
    route_table_id = module.Uat_rtb.rtb.id
}

// Create the UAT security group
module "Uat_security_group" {
    source = "../SecurityGroup"
    vpc_id = module.Uat_vpc1.vpc.id
    env_prefix = var.env_prefix
}


// Construct the Prod ECR and ECS
module "Uat_ecs_cluster" {
    source = "../ECS"
    ecs_cluster_name = var.ecs_cluster_name
    ecr_repo_name = var.ecr_repo_name
    env_prefix = var.env_prefix
    ecs_subnets = module.Uat_subnets.subnet_ids_list
    assign_public_ip = true
    ecs_security_group = module.Uat_security_group.security_group_info.id
    lb_target_group = var.uat_lb_tg
    task_role_arn = var.task_role_arn
    ecr_image_link_prefix = var.ecr_image_link_prefix

}