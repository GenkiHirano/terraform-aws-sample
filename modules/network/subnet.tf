resource "aws_subnet" "public" {
  count                   = 3
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.subnet_public_cidr_block, 4, count.index)
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zones[count.index]
  tags = {
    Name = "${var.name}-public-${var.availability_zones[count.index]}"
  }
}

resource "aws_subnet" "private" {
  count                   = 3
  vpc_id                  = aws_vpc.this.id
  cidr_block              = cidrsubnet(var.subnet_private_cidr_block, 4, count.index)
  map_public_ip_on_launch = false
  availability_zone       = var.availability_zones[count.index]
  tags = {
    Name = "${var.name}-private-${var.availability_zones[count.index]}"
  }
}
