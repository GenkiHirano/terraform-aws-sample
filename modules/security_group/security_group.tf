resource "aws_security_group" "alb" {
  vpc_id      = var.vpc_id
  name        = "${var.service}-${var.env}-alb-sg"
  description = "${var.service}-${var.env}-alb-sg"

  tags = {
    Name = "${var.service}-${var.env}-alb-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "alb" {
  security_group_id = aws_security_group.alb.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "TCP"
  cidr_ipv4         = ["0.0.0.0/0"]
}

resource "aws_vpc_security_group_egress_rule" "alb" {
  security_group_id = aws_security_group.alb.id
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
  cidr_ipv4         = ["0.0.0.0/0"]
}

resource "aws_security_group" "app" {
  vpc_id      = var.vpc_id
  name        = "${var.service}-${var.env}-app-sg"
  description = "${var.service}-${var.env}-app-sg"

  tags = {
    Name = "${var.service}-${var.env}-app-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "app" {
  security_group_id            = aws_security_group.app.id
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "TCP"
  referenced_security_group_id = aws_security_group.alb.id
}

resource "aws_vpc_security_group_egress_rule" "app" {
  security_group_id = aws_security_group.app.id
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
  cidr_ipv4         = ["0.0.0.0/0"]
}

resource "aws_security_group" "db" {
  vpc_id      = var.vpc_id
  name        = "${var.service}-${var.env}-db-sg"
  description = "${var.service}-${var.env}-db-sg"

  tags = {
    Name = "${var.service}-${var.env}-db-sg"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_vpc_security_group_ingress_rule" "db" {
  security_group_id            = aws_security_group.db.id
  from_port                    = 3306
  to_port                      = 3306
  ip_protocol                  = "TCP"
  referenced_security_group_id = aws_security_group.app.id
}

resource "aws_vpc_security_group_egress_rule" "db" {
  security_group_id = aws_security_group.db.id
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
  cidr_ipv4         = ["0.0.0.0/0"]
}