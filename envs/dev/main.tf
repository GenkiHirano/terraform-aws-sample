module "vpc" {
  source                    = "../../modules/vpc"
  name                      = "${local.service}-${local.env}"
  availability_zones        = local.availability_zones
  vpc_id                    = module.vpc.vpc_id
  port                      = local.port
  vpc_cidr_block            = local.vpc_cidr_block
  subnet_public_cidr_block  = local.subnet_public_cidr_block
  subnet_private_cidr_block = local.subnet_private_cidr_block
  route_table_cidr_block    = local.route_table_cidr_block
  security_group_cidr_block = local.security_group_cidr_block
}
