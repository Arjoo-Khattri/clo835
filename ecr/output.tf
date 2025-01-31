
# outputs.tf

output "webapp_repository_url" {
  description = "The URL of the webapp repository"
  value       = aws_ecr_repository.webapp.repository_url
}

output "mysql_repository_url" {
  description = "The URL of the MySQL repository"
  value       = aws_ecr_repository.mysql.repository_url
}