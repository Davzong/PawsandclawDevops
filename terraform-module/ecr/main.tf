resource "aws_ecr_repository" "ecr" {
  name                 = "terraform-ecr"
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = false
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Name        = var.prefix
    Environment = "Production"
  }
}

output "repository_name" {
  value = aws_ecr_repository.ecr.name
}
output "repo_url" {
  value = aws_ecr_repository.ecr.repository_url
}
