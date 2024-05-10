output "public_subnet_id" {
  value = aws_subnet.public_subnet [*].id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.gw.id
}