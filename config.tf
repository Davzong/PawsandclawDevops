terraform{
   required_providers {
    aws = {
      version = "~> 4.34.0"
    }
  }
}

provider "aws" {
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
    region = "us-west-2"
}