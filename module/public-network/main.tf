resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = var.vpc_id

}

resource "aws_route_table" "route_table" {
  vpc_id = var.vpc_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}
resource "aws_route_table_association" "aats" {
  route_table_id = aws_route_table.route_table.id
  count = length(var.subnet_ids)
  subnet_id = var.subnet_ids[count.index]
}