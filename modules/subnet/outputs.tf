output "subnet_ids_map" {
  value = tomap({
    for idx, subnet in aws_subnet.my_subnet : idx => subnet.id
  })
}

output "subnet_ids_list" {
  value = [for subnet in aws_subnet.my_subnet : subnet.id]
}