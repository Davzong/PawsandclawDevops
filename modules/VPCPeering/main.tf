// Create VPC Peering Connection
resource "aws_vpc_peering_connection" "VPC_peer" {
  peer_vpc_id   = var.vpc_uat_id_for_peering
  vpc_id        = var.prod_vpc_id
  auto_accept   = true
  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}





# Update UAT VPC network ACL
resource "aws_network_acl" "uat_network_acl" {
  vpc_id = var.vpc_uat_id_for_peering
  
  # Define ingress and egress rules for UAT VPC
  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.prod_vpc_cidr_block
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.prod_vpc_cidr_block
    from_port  = 0
    to_port    = 0
  }
}

# Update production VPC network ACL
resource "aws_network_acl" "prod_network_acl" {
  vpc_id = var.prod_vpc_id

  # Define ingress and egress rules for production VPC
  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.vpc_uat_cidr_for_peering
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = var.vpc_uat_cidr_for_peering
    from_port  = 0
    to_port    = 0
  }
}
