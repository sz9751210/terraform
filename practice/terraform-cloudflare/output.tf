output "dns_records_details" {
  value = [for r in module.cloudflare_dns_records : {
    address = r.value
    name    = r.name
    type    = r.type
    ttl     = r.ttl
    proxied = r.proxied
  }]
}
