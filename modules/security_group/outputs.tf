output "alb_id" {
  value = aws_security_group.alb.id
}

output "app_id" {
  value = aws_security_group.app.id
}

output "db_id" {
  value = aws_security_group.db.id
}
