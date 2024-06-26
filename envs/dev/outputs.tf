output "access_control_ecs" {
  value = module.access_control_ecs
}

output "network" {
  value = module.network
}

output "storage" {
  value = module.storage
}

output "firewall_sg" {
  value = module.firewall_sg
}

output "firewall_http_sg" {
  value = module.firewall_http_sg
}

output "firewall_https_sg" {
  value = module.firewall_https_sg
}

output "firewall_http_redirect_sg" {
  value = module.firewall_http_redirect_sg
}

output "firewall_nginx_sg" {
  value = module.firewall_nginx_sg
}

output "firewall_rds_sg" {
  value = module.firewall_rds_sg
}

output "firewall_redis_sg" {
  value = module.firewall_rds_sg
}

output "load_balancer" {
  value = module.load_balancer
}

output "dns" {
  value = module.dns
}

output "container" {
  value = module.container
}

output "monitoring_ecs" {
  value = module.monitoring_ecs
}

output "encryption" {
  value = module.encryption
}

output "setting_management" {
  value = module.setting_management
}

output "data_store" {
  value = module.data_store
}
