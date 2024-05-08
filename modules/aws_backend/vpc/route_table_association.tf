resource "aws_route_table_association" "public_lb_route_table_association" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.lb_subnet.*.id, count.index)
  route_table_id = aws_route_table.lb_subnet.id
}

resource "aws_route_table_association" "ecs_route_table_association" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.ecs_subnet.*.id, count.index)
  route_table_id = aws_route_table.ecs_route.id
}
