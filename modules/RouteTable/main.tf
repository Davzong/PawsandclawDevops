// Route table module for UAT and Prod Public Subnets
resource "aws_route_table" "my_rtb" {
    vpc_id = var.vpc_id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = var.gateway_id
    }

    route{
        cidr_block = var.peering_vpc_cidr
        vpc_peering_connection_id = var.vpc_peering_id
    }
    tags = {
        Name = "${var.env_prefix}-rtb"
    }
}

