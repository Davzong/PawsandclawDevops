resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = merge({
    Name = "Internet-Gateway-${var.workspace}"
  }, var.default_tags)
}
