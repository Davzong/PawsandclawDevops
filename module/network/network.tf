# network.tf

# Fetch AZs in the current region
data "aws_availability_zones" "available" {
}

resource "aws_vpc" "main" {
    cidr_block = "172.17.0.0/16"
    tags = {
        Name = "Main VPC"
    }
}

# Create var.az_count private subnets, each in a different AZ
resource "aws_subnet" "private" {
    count             = var.az_count
    cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
    availability_zone = data.aws_availability_zones.available.names[count.index]
    vpc_id            = aws_vpc.main.id
    tags = {
        Name = format("private subnet%d",count.index+1)
    }
    
}

# Create var.az_count public subnets, each in a different AZ
resource "aws_subnet" "public" {
    count                   = var.az_count
    cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, var.az_count + count.index)
    availability_zone       = data.aws_availability_zones.available.names[count.index]
    vpc_id                  = aws_vpc.main.id
    map_public_ip_on_launch = true
    tags = {
        Name = format("public subnet%d",count.index+1)
    }
}

# Internet Gateway for the public subnet
resource "aws_internet_gateway" "gw" {
    vpc_id = aws_vpc.main.id
}

# Route the public subnet traffic through the IGW
# resource "aws_route" "internet_access" {
#     route_table_id         = aws_vpc.main.main_route_table_id
#     destination_cidr_block = "0.0.0.0/0"
#     gateway_id             = aws_internet_gateway.gw.id
# }

# Create a NAT gateway with an Elastic IP for each private subnet to get internet connectivity
resource "aws_eip" "gw" {
    count      = var.az_count
    domain = "vpc"
    depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "gw" {
    count         = var.az_count
    subnet_id     = element(aws_subnet.public.*.id, count.index)
    allocation_id = element(aws_eip.gw.*.id, count.index)
}

# Create a new route table for the public subnets
resource "aws_route_table" "public" {
    count  = var.az_count
    vpc_id = aws_vpc.main.id

    route {
        cidr_block     = "0.0.0.0/0"
        gateway_id     = aws_internet_gateway.gw.id
    }

    tags = {
        Name = format("Public route table%d",count.index+1)
    }
}

# Explicitly associate the newly created public route tables to the public subnets
resource "aws_route_table_association" "public" {
    count          = var.az_count
    subnet_id      = element(aws_subnet.public.*.id, count.index)
    route_table_id = element(aws_route_table.public.*.id, count.index)
}


# Create a new route table for the private subnets, make it route non-local traffic through the NAT gateway to the internet
resource "aws_route_table" "private" {
    count  = var.az_count
    vpc_id = aws_vpc.main.id

    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = element(aws_nat_gateway.gw.*.id, count.index)
    }

    tags = {
        # Name = join("PrivateRouteTable",tostring(count.index))
        	
        Name = format("Private route table%d",count.index+1)
    }
}

# Explicitly associate the newly created route tables to the private subnets (so they don't default to the main route table)
resource "aws_route_table_association" "private" {
    count          = var.az_count
    subnet_id      = element(aws_subnet.private.*.id, count.index)
    route_table_id = element(aws_route_table.private.*.id, count.index)
}