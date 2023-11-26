resource "aws_eip" "natgateway" {
  domain = "vpc"
  count  = 3

  tags = {
    Name = "${var.service}-${var.env}"
  }
}

resource "aws_nat_gateway" "this" {
  count         = 3
  allocation_id = aws_eip.natgateway[count.index].id
  subnet_id = aws_subnet.public[count.index].id

  tags = {
    Name = "${var.service}-${var.env}"
  }
}
