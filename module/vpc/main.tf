resource "aws_vpc" "VPC" {
    cidr_block = var.cidr_block
    tags = {
        Name = "${var.prefix}-vpc"
        project = "${var.prefix}-project"
    }
}
