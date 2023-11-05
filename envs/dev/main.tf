module "vpc" {
  source              = "../modules/vpc"
  service             = var.service
  env                 = var.env
  vpc_cidr_block      = var.vpc_cidr_block
  availability_zones  = var.availability_zones
  subnet_public_cidr  = var.subnet_public_cidr
  subnet_private_cidr = var.subnet_private_cidr
}
