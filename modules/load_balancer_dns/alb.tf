resource "aws_lb" "this" {
  name               = var.name
  load_balancer_type = "application"
  internal           = false
  idle_timeout       = 60
  // 削除保護: 本番環境で誤って削除されないようにする
  // NOTE: 検証段階では削除はしたいので、コメントアウト
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