health_check = "/status"

default_tags = {
  Environment = "UAT"
  Project     = "Paws-and-claws"
}

container_port = 3000

vpc_id = "vpc-023fa9a656457a8d1"

lb_sg_id = "sg-036e1e28897b57b04"

lb_subnet_id = ["subnet-0dc37deedb9619b8d", "subnet-05f6d646f8a9cad5b"]


workspace = "UAT"
