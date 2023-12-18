output "aws_db_instance_id" {
  value = aws_db_instance.this.id
}

output "aws_elasticache_parameter_group_id" {
  value = aws_elasticache_parameter_group.this.id
}
