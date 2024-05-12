resource "aws_ecr_repository" "app_repository" {
  name                 = "my-app-repo"  # Name of the repository
  image_tag_mutability = "MUTABLE"
}
