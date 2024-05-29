# Prod IaC 

// Build the Prod VPC
module "Prod_vpc1" {
    source = "../vpc"
    env_prefix = var.prod_env_prefix
    vpc_cidr_block = var.vpc_cidr_block

}

// Create the Prod Public Subnets
module "Prod_public_subnets" {
    source = "../subnet"
    env_prefix = var.prod_env_prefix
    vpc_id = module.Prod_vpc1.vpc.id
    subnet_cidr_block = var.prod_public_subnet_cidr_block
    avail_zone = var.avail_zone
    subnet_names = var.prod_public_subnet_names

}

// Create the Prod Private Subnets
module "Prod_private_subnets" {
    source = "../subnet"
    env_prefix = var.prod_env_prefix
    vpc_id = module.Prod_vpc1.vpc.id
    subnet_cidr_block = var.prod_private_subnet_cidr_block
    avail_zone = var.avail_zone
    subnet_names = var.prod_private_subnet_names

}


// Create the Prod Internet Gateway
module "Prod_igw" {
    source = "../InternetGateway"
    env_prefix = var.prod_env_prefix
    vpc_id = module.Prod_vpc1.vpc.id
}

// Link the Prod Public Route Table
module "Prod_rtb" {
    source = "../RouteTable"
    env_prefix = var.prod_env_prefix
    vpc_id = module.Prod_vpc1.vpc.id
    gateway_id = module.Prod_igw.igw.id
    vpc_peering_id = var.vpc_peering_id
    peering_vpc_cidr = var.peering_vpc_cidr
}


// Link the Prod Private Route Table
module "Prod_private_rtb" {
    source = "../ProdPrivateRT"
    env_prefix = var.prod_env_prefix
    vpc_id = module.Prod_vpc1.vpc.id
    subnet_ids_list = module.Prod_private_subnets.subnet_ids_list
    subnet_ids_list_for_Nat_Gateway = module.Prod_public_subnets.subnet_ids_list

}


// Associate the Public Subet to the Public Route
module "Prod_rtb_association" {
    source = "../RouteTBAssociation"
    subnet_ids_list = module.Prod_public_subnets.subnet_ids_list
    route_table_id = module.Prod_rtb.rtb.id
}

// Create the Prod Public Security Group
module "Prod_security_group" {
    source = "../SecurityGroup"
    env_prefix = var.prod_env_prefix
    vpc_id = module.Prod_vpc1.vpc.id
}

// Create the Prod Private Security Group
module "Prod_private_security_group" {
    source = "../ProdPrivateSecurityGroup"
    env_prefix = var.prod_env_prefix
    vpc_id = module.Prod_vpc1.vpc.id
    public_sg_id = module.Prod_security_group.security_group_info.id
}


// Create the VPC peering for UAT and Prod VPCs
module "create_vpc_peering" {
    source = "../VPCPeering"
    prod_vpc_id = module.Prod_vpc1.vpc.id
    prod_vpc_cidr_block = module.Prod_vpc1.vpc.cidr_block
    prod_rtb_id = module.Prod_rtb.rtb.id
    vpc_uat_id_for_peering = var.vpc_uat_id_for_peering
    vpc_uat_cidr_for_peering = var.vpc_uat_cidr_for_peering
    vpc_uat_rtb_id = var.vpc_uat_rtb_id
}

// Create the ALB for UAT and Prod ECS task
module "create_load_balancer" {
    source = "../LoadBalancer"
    env_prefix = var.prod_env_prefix
    subnet_ids_list = module.Prod_public_subnets.subnet_ids_list
    prod_ecs_service_info = module.Prod_ecs.ECS_info
    prod_vpc_id = module.Prod_vpc1.vpc.id

    uat_ecs_service_info = var.uat_ecs_service_info
    uat_subnet_ids_list = var.uat_subnet_ids_list
    nat_load_balancer_security_group_id = var.nat_load_balancer_security_group_id
    uat_ecs_taskdefinition = var.uat_ecs_taskdefinition

    vpc_uat_id_for_peering = var.vpc_uat_id_for_peering
    load_balancer_security_group_id = module.Prod_security_group.security_group_info.id

}


// Construct the Prod ECR and ECS
module "Prod_ecs" {
    source = "../ECS"
    env_prefix = var.prod_env_prefix
    ecs_cluster_name = var.prod_ecs_cluster_name
    ecr_repo_name = var.prod_ecr_repo_name
    ecs_subnets = module.Prod_private_subnets.subnet_ids_list
    assign_public_ip = false

    ecs_security_group = module.Prod_private_security_group.prod_private_sg.id
    lb_target_group = module.create_load_balancer.prod_lb_tg
    task_role_arn = var.task_role_arn
    ecr_image_link_prefix = var.ecr_image_link_prefix

}



// Below is for the front end
module "route_ALBtraffic_to_domain" {
    source = "../Route53"
    alb_info = module.create_load_balancer.alb_info
    host_web_address = var.host_web_address
}