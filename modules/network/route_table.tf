resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    gateway_id = aws_internet_gateway.this.id
    cidr_block = var.route_table_cidr_block
  }

  tags = {
    Name = var.name
  }
}

resource "aws_route_table" "private" {
  count  = 3
  vpc_id = aws_vpc.this.id

  route {
    nat_gateway_id = aws_nat_gateway.this[count.index].id
    cidr_block     = var.route_table_cidr_block

  }

  tags = {
    Name = "${var.name}-private-${var.availability_zones[count.index]}"
  }
}

resource "aws_route_table_association" "public" {
  count          = 3
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "private" {
  count          = 3
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
