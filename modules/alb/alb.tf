resource "aws_alb" "public_alb" {
  name            = "${var.service}-${var.env}-public-alb"
  load_balancer_type = "application"
  internal        = false
  security_groups = var.public_alb_security_groups
  subnets         = var.subnet_public_ids

  enable_deletion_protection = false
  idle_timeout               = "10"

  lifecycle {
  }

  tags = {
    Name = "${var.service}-${var.env}-public-alb"
  }
}

resource "aws_alb_target_group" "public_http_target_group" {
  name                 = "${var.service}-${var.env}-public-http-tg"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  deregistration_delay = 60
  target_type          = "ip"
  depends_on           = [aws_alb.public_alb]

  lifecycle {
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    path                = "/index.html"
    matcher             = "200-499"
  }

  tags = {
    Name = "${var.service}-${var.env}-public-http-tg"
  }
}

resource "aws_alb_listener" "public_https_listener" {
  load_balancer_arn = aws_alb.public_public_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.api_ssl_arn
  depends_on        = [aws_alb.public_alb]

  tags = {
    Name = "${var.service}-${var.env}-public-https-listener"
  }

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.public_http_target_group.arn
  }
}

resource "aws_alb_listener" "public_http_listener" {
  load_balancer_arn = aws_alb.public_alb.arn
  port              = 80
  protocol          = "HTTP"
  depends_on        = [aws_alb.public_alb]

  tags = {
    Name = "${var.service}-${var.env}-public-http-listener"
  }

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
