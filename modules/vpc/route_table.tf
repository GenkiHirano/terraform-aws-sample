resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "${var.service}-${var.env}"
  }
}

resource "aws_route_table" "private" {
  count  = 3
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    # nat_gateway_id = element(aws_nat_gateway.this.*.id, count.index)
  }

  tags = {
    Name = "${var.service}-${var.env}"
  }
}
