# Allocate Elastic IP (EIP)
resource "aws_eip" "nat_gateway_eip" {
  domain = "vpc"
}

// Create NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
    #count = length(var.subnet_ids_list)
    allocation_id = aws_eip.nat_gateway_eip.id
    subnet_id     = var.subnet_ids_list_for_Nat_Gateway[0]  # Public subnet ID where the NAT Gateway will be deployed
}


// Route the subnet network
resource "aws_route_table" "private_subnet_route_table" {
  vpc_id = var.vpc_id  # ID of the VPC where the route table will be created

  tags = {
    Name = "${var.env_prefix}_private_rtb"  # Replace with a suitable name for your route table
  }
}


// associatee the subnet into the network
resource "aws_route_table_association" "my-rtb-association" {
    count = length(var.subnet_ids_list)
    subnet_id      = var.subnet_ids_list[count.index]
    route_table_id = aws_route_table.private_subnet_route_table.id 
}


# Update Route Table for Private Subnet
resource "aws_route" "private_subnet_route" {
  route_table_id            = aws_route_table.private_subnet_route_table.id  # ID of the private subnet's route table
  destination_cidr_block   = "0.0.0.0/0"  # Route all traffic
  nat_gateway_id            = aws_nat_gateway.nat_gateway.id
}
