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

output "load_balancer_dns" {
  value = module.load_balancer_dns
}
