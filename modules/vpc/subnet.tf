resource "aws_subnet" "public" {
  count             = 3
  vpc_id            = aws_vpc.this.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = cidrsubnet("${var.subnet_public_cidr}", 4, count.index)
  tags = {
    Name = "${var.service}-${var.env}-public-${var.availability_zones[count.index]}"
  }
}

resource "aws_subnet" "private" {
  count             = 3
  vpc_id            = aws_vpc.this.id
  availability_zone = var.availability_zones[count.index]
  cidr_block        = cidrsubnet("${var.subnet_private_cidr}", 4, count.index)
  tags = {
    Name = "${var.service}-${var.env}-app-${var.availability_zones[count.index]}"
  }
}
