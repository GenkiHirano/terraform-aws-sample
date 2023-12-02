resource "aws_eip" "ngw" {
  count      = 3
  domain     = "vpc"
  depends_on = [aws_internet_gateway.this]

  tags = {
    Name = "${var.name}-${var.availability_zones[count.index]}"
  }
}

resource "aws_nat_gateway" "this" {
  count         = 3
  allocation_id = aws_eip.ngw[count.index].id
  subnet_id     = aws_subnet.public[count.index].id
  depends_on    = [aws_internet_gateway.this]

  tags = {
    Name = "${var.name}-${var.availability_zones[count.index]}"
  }
}
