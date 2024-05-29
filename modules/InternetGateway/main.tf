// Internet Gateway Module for both UAT and Prod publiic network
resource "aws_internet_gateway" "my-igw" {
    vpc_id = var.vpc_id
    tags = {
        Name = "${var.env_prefix}-igw"
    }
}