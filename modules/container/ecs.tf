resource "aws_ecs_cluster" "this" {
  name = var.name
}

resource "aws_ecs_task_definition" "this" {
  family                   = var.name
  cpu                      = "256"
  memory                   = "512"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("${path.module}/container_definition.json")
  execution_role_arn       = var.execution_role_arn
}

resource "aws_ecs_service" "this" {
  name                              = var.name
  cluster                           = aws_ecs_cluster.this.arn
  task_definition                   = aws_ecs_task_definition.this.arn
  desired_count                     = 2
  launch_type                       = "FARGATE"
  platform_version                  = "1.3.0"
  health_check_grace_period_seconds = 60

  network_configuration {
    assign_public_ip = false
    security_groups  = [var.security_groups_id]
    subnets          = var.subnet_private_ids
  }

  load_balancer {
    target_group_arn = var.load_balancer_target_group_arn
    container_name   = var.name
    container_port   = 80
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}

