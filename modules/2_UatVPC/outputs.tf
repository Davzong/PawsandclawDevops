output "uat_vpc" {
    value = module.Uat_vpc1.vpc
}


output "uat_rtb" {
    value = module.Uat_rtb.rtb
}



output "uat_ecs_info" {
    value = module.Uat_ecs_cluster.ECS_info
}

output "uat_subnet_ids_list" {
    value = module.Uat_subnets.subnet_ids_list
}


output "nat_load_balancer_security_group_id" {
    value = module.Uat_security_group.security_group_info.id
}


output "uat_ecs_taskdefinition" {
    value = module.Uat_ecs_cluster.ecs_taskdefinition
}
