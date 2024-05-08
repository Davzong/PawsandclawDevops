resource "aws_route_table" "lb_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge({
    Name = "lb-route-${var.workspace}"
  }, var.default_tags)
}





resource "aws_route_table" "ecs_route" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id # 使用 Internet Gateway
  }

  tags = merge({
    Name = "ecs-route-${var.workspace}"
  }, var.default_tags)

}

