variable env_prefix {
    description = "Terrafrom build env"
    type = string
}
variable subnet_ids_list {
    type = list(string)
}
variable uat_ecs_service_info {}
variable prod_ecs_service_info {}
variable prod_vpc_id {}
variable vpc_uat_id_for_peering {}
variable load_balancer_security_group_id {}
variable nat_load_balancer_security_group_id {}



variable uat_subnet_ids_list{
    type = list(string)
}

variable uat_ecs_taskdefinition {}

