module "network" {
  source                    = "../../modules/network"
  name                      = "${local.service}-${local.env}"
  availability_zones        = local.availability_zones
  vpc_id                    = module.network.vpc_id
  vpc_cidr_block            = local.vpc_cidr_block
  subnet_public_cidr_block  = local.subnet_public_cidr_block
  subnet_private_cidr_block = local.subnet_private_cidr_block
  route_table_cidr_block    = local.route_table_cidr_block
}

module "storage" {
  source      = "../../modules/storage"
  name        = "${local.service}-${local.env}"
  identifiers = local.s3_identifiers
}

module "firewall_sg" {
  source                    = "../../modules/firewall"
  name                      = "${local.service}-${local.env}-sg"
  vpc_id                    = module.network.vpc_id
  port                      = local.port
  security_group_cidr_block = local.security_group_cidr_block
}

module "firewall_http_sg" {
  source                    = "../../modules/firewall"
  name                      = "${local.service}-${local.env}-http-sg"
  vpc_id                    = module.network.vpc_id
  port                      = local.port
  security_group_cidr_block = local.security_group_cidr_block
}

module "firewall_https_sg" {
  source                    = "../../modules/firewall"
  name                      = "${local.service}-${local.env}-https-sg"
  vpc_id                    = module.network.vpc_id
  port                      = 443
  security_group_cidr_block = local.security_group_cidr_block
}

module "firewall_http_redirect_sg" {
  source                    = "../../modules/firewall"
  name                      = "${local.service}-${local.env}-http-redirect-sg"
  vpc_id                    = module.network.vpc_id
  port                      = 8080
  security_group_cidr_block = local.security_group_cidr_block
}

module "load_balancer" {
  source                          = "../../modules/load_balancer"
  name                            = "${local.service}-${local.env}"
  vpc_id                          = module.network.vpc_id
  subnet_public_ids               = module.network.subnet_public_ids
  http_security_group_id          = module.firewall_http_sg.security_group_id
  https_security_group_id         = module.firewall_https_sg.security_group_id
  http_redirect_security_group_id = module.firewall_http_redirect_sg.security_group_id
  alb_log_bucket_id               = module.storage.alb_log_bucket_id
  acm_certificate_arn             = module.dns.acm_certificate_arn
}

module "dns" {
  source   = "../../modules/dns"
  domain   = local.domain
  dns_name = module.load_balancer.alb_dns_name
  zone_id  = module.load_balancer.zone_id
}
