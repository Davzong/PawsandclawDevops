

output "prod_vpc_id" {
    value = module.Prod_vpc1.vpc.id
}


output "lb_tg" {
    value = module.create_load_balancer.lb_tg
}

output "vpc_peering_id" {
    value = module.create_vpc_peering.vpc_peering_id
}