// Module for the UAT and Prod to create the needed subnets
resource "aws_subnet" "my_subnet" {
    count = length(var.subnet_cidr_block)
    vpc_id = var.vpc_id
    cidr_block = var.subnet_cidr_block[count.index]
    availability_zone = var.avail_zone[count.index]
    tags = {
        Name = "${var.subnet_names[count.index]}"
    }

}