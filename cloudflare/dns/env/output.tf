output "lab_dns_records" {
  value = [
    for record in local.dns_records : {
      name       = record.subdomain
      ip_address = record.ip_address
    }
  ]
}
