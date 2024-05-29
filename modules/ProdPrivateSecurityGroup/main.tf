// Private Security group module for the Prod Private Subnet task
resource "aws_security_group" "private_sg" {
    name = "${var.env_prefix}-private-sg"
    vpc_id = var.vpc_id
    
    ingress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        security_groups  = ["${var.public_sg_id}"]  # Allow traffic between private and public subnets
    }

    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        prefix_list_ids = []
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        security_groups  = ["${var.public_sg_id}"]  # Allow traffic between private and public subnets
    }

    tags = {
        Name = "${var.env_prefix}-private-sg"
    }
}