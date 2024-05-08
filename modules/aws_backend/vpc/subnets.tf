resource "aws_subnet" "lb_subnet" {
  count                   = var.az_count
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = cidrsubnet(aws_vpc.main_vpc.cidr_block, 4, count.index)
  availability_zone_id    = data.aws_availability_zones.available.zone_ids[count.index % 2]
  map_public_ip_on_launch = true

  tags = merge(
    {
      "Name" : "lb-subnet-${count.index}-${var.workspace}"
  }, var.default_tags)
}

resource "aws_subnet" "ecs_subnet" {
  count                = var.az_count
  vpc_id               = aws_vpc.main_vpc.id
  cidr_block           = cidrsubnet(aws_vpc.main_vpc.cidr_block, 4, count.index + 2)
  availability_zone_id = data.aws_availability_zones.available.zone_ids[count.index % 2]

  tags = merge(
    {
      "Name" : "ecs-subnet-${count.index}-${var.workspace}"
  }, var.default_tags)
}

