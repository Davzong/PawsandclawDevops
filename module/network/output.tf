output "aws_vpc_id" {
    value = aws_vpc.main.id
}

output "aws_subnet_public" {
    value = aws_subnet.public
}

output "aws_subnet_private" {
    value = aws_subnet.private
}