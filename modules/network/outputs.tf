output "vpc_id" {
  value = aws_vpc.this.id
}

output "subnet_public_ids" {
  value = aws_subnet.public[*].id
}

output "subnet_private_ids" {
  value = aws_subnet.private[*].id
}

output "route_table_public_id" {
  value = aws_route_table.public.id
}

output "route_table_private_ids" {
  value = aws_route_table.private[*].id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.this.id
}

output "eip_ids" {
  value = aws_eip.ngw[*].id
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.this[*].id
}
