vpc_cidr             = "10.0.0.0/16"
availability_zones   = ["ap-southeast-2a", "ap-southeast-2b","ap-southeast-2c"]
# "10.0.0.0/24", "10.0.1.0/24" as public subnet
# "10.0.128.0/24", "10.0.129.0/24" as private subnet
subnet = ["10.0.1.0/24", "10.0.2.0/24", "10.0.128.0/24", "10.0.129.0/24"]
prefix = "Pawsandclaws"
region = "ap-southeast-2"