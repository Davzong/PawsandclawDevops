resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = var.public_subnet_id
}
resource "aws_eip" "nat_eip" {
  tags = {
    Name = "${var.prefix}-eip-${var.num}"
  }
}
resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_gateway.id
  }
}
resource "aws_route_table_association" "aats" {
  route_table_id = aws_route_table.route_table.id
  count = length(var.private_subnet_ids)
  subnet_id = var.private_subnet_ids[count.index]
}