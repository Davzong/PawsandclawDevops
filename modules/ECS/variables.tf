variable env_prefix {
    description = "Terrafrom build env"
    type = string
}

variable ecs_cluster_name {
    description = "ECS cluster name"
    type = string
}


variable ecr_repo_name {
    description = "ECR repo name"
    type = string
}


variable ecs_subnets {
    type = list(string)
}


variable assign_public_ip {
    description = "Yes or No to trun on or off for the assigning public id for ecs task"
}

variable ecs_security_group {
    description = "sg for the ECS task"
}

variable lb_target_group {
    description = "Target group for the load balancer"
}

variable task_role_arn {}
variable ecr_image_link_prefix {}