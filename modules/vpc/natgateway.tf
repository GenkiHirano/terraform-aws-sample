resource "aws_eip" "natgateway" {
  vpc   = true
  count = 3

  tags = {
    Name = "${var.service}-${var.env}"
  }
}

resource "aws_nat_gateway" "this" {
  count         = 3
  allocation_id = aws_eip.natgateway[count.index].id
  subnet_id     = element(aws_subnet.public.*.id, count.index)

  tags = {
    Name = "${var.service}-${var.env}"
  }
}
