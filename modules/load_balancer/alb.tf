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
