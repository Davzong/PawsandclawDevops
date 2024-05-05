resource "aws_subnet" "subnet" {
    vpc_id = var.vpc_id
    cidr_block = var.subnet_block
    availability_zone = var.availability_zones
    tags = {
      Name = "${var.prefix}-${var.subnet_name}"
    }
}