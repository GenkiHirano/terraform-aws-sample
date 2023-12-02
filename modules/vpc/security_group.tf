resource "aws_security_group" "this" {
  name   = var.name
  vpc_id = var.vpc_id

  tags = {
    Name = var.name
  }
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  security_group_id = aws_security_group.this.id
  from_port         = var.port
  to_port           = var.port
  ip_protocol       = "tcp"
  cidr_ipv4         = var.security_group_cidr_block
}

resource "aws_vpc_security_group_egress_rule" "this" {
  security_group_id = aws_security_group.this.id
  from_port         = 0
  to_port           = 0
  ip_protocol       = "-1"
  cidr_ipv4         = var.security_group_cidr_block
}