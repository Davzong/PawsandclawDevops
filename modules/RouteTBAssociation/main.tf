// Route table associate for UAT and Prod public subnet
resource "aws_route_table_association" "my-rtb-association" {
    count = length(var.subnet_ids_list)
    subnet_id      = var.subnet_ids_list[count.index]
    route_table_id = var.route_table_id
}