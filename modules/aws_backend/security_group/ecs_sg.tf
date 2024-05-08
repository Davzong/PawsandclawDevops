resource "aws_security_group" "ecs_sg" {
  name        = "Ecs-Server-Security-Group-${var.workspace}"
  description = "Enable HTTP/HTTPS access on Port 80/443 via ALB SG for ECS SG"
  vpc_id      = var.vpc_id

  ingress {
    description     = "HTTP Access"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = ["${aws_security_group.lb_sg.id}"]
  }
  ingress {
    description     = "allowed traffic"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = ["${aws_security_group.lb_sg.id}"]
  }

  egress {
    description = "blocked traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      "Name" : "Ecs-Server-Security-Group-${var.workspace}"
    }, var.default_tags
  )
}


