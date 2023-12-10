output "aws_ecs_cluster_id" {
  value = aws_ecs_cluster.this.id
}

output "aws_ecs_task_definition_id" {
  value = aws_ecs_task_definition.this.id
}

output "aws_ecs_service_id" {
  value = aws_ecs_service.this.id
}
