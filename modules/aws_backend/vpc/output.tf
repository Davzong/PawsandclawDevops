output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "lb_subnet_id" {
  value = aws_subnet.lb_subnet.*.id
}

output "ecs_subnet_id" {
  value = aws_subnet.ecs_subnet.*.id
}
