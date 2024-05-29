variable env_prefix {}
variable vpc_cidr_block {}
variable subnet_cidr_block {
    type = list(string)
}
variable subnet_names {
    type = list(string)
}
variable avail_zone {
    type = list(string)
}

variable ecr_repo_name {
    description = "ECR repo name"
    type = string
}

variable ecs_cluster_name {
    description = "ECS cluster name"
    type = string
}


variable uat_lb_tg {
    description = "uat load balancer target group"
}

variable vpc_peering_id {
    description = "VPC peering id"
}

variable peering_vpc_cidr {}
variable task_role_arn {}
variable ecr_image_link_prefix {}