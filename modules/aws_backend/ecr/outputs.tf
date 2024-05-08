output "default_backend_image" {
  value = aws_ecr_repository.main_ecr.repository_url
}
