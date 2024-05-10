# create public subnet
resource "aws_subnet" "public_subnet" {
  count                   = 2
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[count.index]

  tags = {
      Name = "${var.prefix}-public_subnet"
    }
}

# create Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id
  
  tags = {
    Name = "${var.prefix}-gw"
  }
}


# create route table to connect subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.prefix}-public_route_table"
  }
}

# create route (rules) to define how traffic should be forwarded
# such as through an Internet Gateway, NAT Gateway, VPC Peering Connection,

resource "aws_route" "public_subnet_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"  # all traffic
  gateway_id             = aws_internet_gateway.gw.id
}

# connect public_subnet to route_table
resource "aws_route_table_association" "public_subnet_association" {
  count = length(aws_subnet.public_subnet)

  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}
