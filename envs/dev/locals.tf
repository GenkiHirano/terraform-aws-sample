locals {
  service                   = "terraform-aws-sample"
  env                       = "dev"
  aws_region                = "ap-northeast-1"
  availability_zones        = ["ap-northeast-1a", "ap-northeast-1c", "ap-northeast-1d"]
  vpc_cidr_block            = "10.10.0.0/16"
  subnet_public_cidr_block  = "10.10.64.0/20"
  subnet_private_cidr_block = "10.10.80.0/20"
  route_table_cidr_block    = "0.0.0.0/0"
  security_group_cidr_block = "0.0.0.0/0"
  port                      = "80"
}
