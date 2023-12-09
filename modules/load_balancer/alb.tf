resource "aws_lb" "this" {
  name               = var.name
  load_balancer_type = "application"
  internal           = false
  idle_timeout       = 60
  // 削除保護: 本番環境で誤って削除されないようにする
  // TODO: 検証段階では削除はしたいので、コメントアウト
  // enable_deletion_protection = true

  subnets = var.subnet_public_ids

  access_logs {
    bucket  = var.alb_log_bucket_id
    enabled = true
  }

  security_groups = [
    var.http_security_group_id,
    var.https_security_group_id,
    var.http_redirect_security_group_id,
  ]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "これは『HTTP』です"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.acm_certificate_arn
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "これは『HTTPS』です"
      status_code  = "200"
    }
  }
}

resource "aws_lb_listener" "redirect_http_to_https" {
  load_balancer_arn = aws_lb.this.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group" "this" {
  name = var.name
  // EC2インスタンスやIPアドレス、Lambda関数などが指定できる（ECS FargateではIPを指定する）
  // TODO: ECSはFargateで良いか確認する
  target_type          = "ip"
  vpc_id               = var.vpc_id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 300

  health_check {
    path                = "/"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = 200
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  depends_on = [aws_lb.this]
}

resource "aws_lb_listener_rule" "this_listener_rule" {
  listener_arn = aws_lb_listener.https.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}
