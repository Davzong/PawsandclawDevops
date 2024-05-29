resource "aws_ecr_repository" "paws-and-claws-ecr" {
  name                 = "paws-and-claws-ecr" # Replace with your desired repository name
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

