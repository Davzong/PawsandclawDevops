resource "aws_security_group" "lb_sg" {
  name        = "ALB-Security-Group-${var.workspace}"
  description = "Elable HTTP/HTTPS acess on Port 80/443 for ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP Accees"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS Access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
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
      "Name" : "ALB-Security-Group-${var.workspace}"
    }, var.default_tags
  )
}
