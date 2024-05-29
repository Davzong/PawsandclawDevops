variable vpc_cidr_block {}
variable prod_env_prefix {}

variable prod_public_subnet_cidr_block {
    type = list(string)
}
variable prod_public_subnet_names  {
    type = list(string)
}
variable prod_private_subnet_cidr_block {
    type = list(string)
}
variable prod_private_subnet_names {
    type = list(string)
}
variable avail_zone {
    type = list(string)
}


variable prod_ecr_repo_name {
    description = "ECR repo name"
    type = string
}

variable prod_ecs_cluster_name {
    description = "ECS cluster name"
    type = string
}


variable vpc_uat_id_for_peering {}
variable vpc_uat_cidr_for_peering {}
variable vpc_uat_rtb_id {}
variable nat_load_balancer_security_group_id {}

variable uat_ecs_service_info {}

variable uat_subnet_ids_list{
    type = list(string)
}


variable uat_ecs_taskdefinition {}

variable vpc_peering_id {
    description = "VPC peering id"
}

variable peering_vpc_cidr {}
variable task_role_arn {}
variable ecr_image_link_prefix {}


// Below is front end part
variable host_web_address {}
