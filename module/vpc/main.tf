resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block

    enable_dns_support   = true
    enable_dns_hostnames = true

    
    tags = {
        Name = "${var.prefix}-vpc"
        project = "${var.prefix}-project"
    }
}

# Create a NAT gateway with an Elastic IP for each private subnet to get internet connectivity

resource "aws_eip" "eip" {
    domain = "vpc"
}

/*resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.eip.id
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "${var.prefix}-nat_gateway"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  #depends_on = [aws_internet_gateway.gw]
}*/
