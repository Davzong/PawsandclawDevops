resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    {
      "Name" : "main-vpc-${var.workspace}"
  }, var.default_tags)
}

# get the current availability zones 
data "aws_availability_zones" "available" {
  state = "available"
}

