# main.tf

provider "aws" {
  region = "us-east-1"
}

# ECR Repository for Web Application
resource "aws_ecr_repository" "webapp" {
  name                 = "webapp-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# ECR Repository for MySQL
resource "aws_ecr_repository" "mysql" {
  name                 = "mysql-repo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}