resource "aws_elasticache_parameter_group" "this" {
  name   = var.name
  family = "redis5.0"
  parameter {
    name  = "cluster-enabled"
    value = "no"
  }
}

resource "aws_elasticache_subnet_group" "this" {
  name       = var.name
  subnet_ids = var.subnet_private_ids
}

resource "aws_elasticache_replication_group" "this" {
  replication_group_id       = var.name
  description                = "cluster disabled"
  engine                     = "redis"
  engine_version             = "5.0.6"
  num_cache_clusters         = 3
  node_type                  = "cache.m4.large"
  snapshot_window            = "09:10-10:10"
  snapshot_retention_limit   = 7
  maintenance_window         = "mon:10:40-mon:11:40"
  automatic_failover_enabled = true
  port                       = 6379
  apply_immediately          = false
  security_group_ids         = [var.redis_security_group_id]
  parameter_group_name       = aws_elasticache_parameter_group.this.name
  subnet_group_name          = aws_elasticache_subnet_group.this.name
}
