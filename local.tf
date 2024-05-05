locals {
    # the availble address are availble to 10.0.0.1 - 10.0.255.254
    vpc_cidr             = "10.0.0.0/16"
    availability_zones   = ["ap-southeast-1a", "ap-southeast-1b"]
    # "10.0.0.0/24", "10.0.1.0/24" as public subnet
    # "10.0.128.0/24", "10.0.129.0/24" as private subnet
    subnet = ["10.0.0.0/24", "10.0.1.0/24", "10.0.128.0/24", "10.0.129.0/24"]
    prefix = "Pawsandclaws"
    region = "ap-southeast-2"

}
# output "subnet" {
#   value = locals.subnet
# }
# output "cidr_block" {
#   value = locals.vpc_cidr
# }
# output "prefix" {
#   value = locals.prefix
# }

# output "ubnet_pub" {
#   value = [locals.subnet[0]+locals.subnet[1]]
# }
# output "subnet_pri" {
#   value = [locals.subnet[2]+locals.subnet[3]]
# }
# output "vpc_cidr" {
#   value = local.vpc_cidr
# }