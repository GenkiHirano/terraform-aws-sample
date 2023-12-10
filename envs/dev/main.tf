module "access_control_ecs" {
  source     = "../../modules/access_control"
  name       = "${local.service}-${local.env}"
  identifier = "ecs-tasks.amazonaws.com"
  policy     = data.aws_iam_policy_document.ecs_task_execution.json
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "ecs_task_execution" {
  // source_jsonを使用すると既存のポリシーを継承できます
  # source_json = data.aws_iam_policy.ecs_task_execution_role_policy.policy

  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameters", "kms:Decrypt"]
    resources = ["*"]
  }
}

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

module "firewall_nginx_sg" {
  source                    = "../../modules/firewall"
  name                      = "${local.service}-${local.env}-nginx-sg"
  vpc_id                    = module.network.vpc_id
  port                      = local.port
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

module "container" {
  source                         = "../../modules/container"
  name                           = "${local.service}-${local.env}"
  subnet_private_ids             = module.network.subnet_private_ids
  security_groups_id             = module.firewall_nginx_sg.security_group_id
  execution_role_arn             = module.access_control_ecs.iam_role_arn
  load_balancer_target_group_arn = module.load_balancer.target_group_arn
}
