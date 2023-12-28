output "global_ip_info" {
  value = { for k, v in google_compute_global_address.global_ip : k => v }
}
