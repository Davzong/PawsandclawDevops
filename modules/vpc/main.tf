// Module for the UAT and Prod to create the VPC
resource "aws_vpc" "my-vpc-1" {
    cidr_block = var.vpc_cidr_block
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
        Name: "${var.env_prefix}-vpc"
    }
}