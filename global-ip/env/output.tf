output "loadbalancer_global_ip_name" {
  value = { for k, v in module.loadbalancer_global_ip.global_ip_info : k => v.name }
}

output "loadbalancer_global_ip_address" {
  value = { for k, v in module.loadbalancer_global_ip.global_ip_info : k => v.address }
}

output "ingress_global_ip_name" {
  value = { for k, v in module.ingress_global_ip.global_ip_info : k => v.name }
}

output "ingress_global_ip_address" {
  value = { for k, v in module.ingress_global_ip.global_ip_info : k => v.address }
}
