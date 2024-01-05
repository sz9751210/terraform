locals {
  dns_records = [
    {
      subdomain  = "ingress-ip"
      ip_address = "127.0.0.1"
      type       = "A"
      proxied    = false
      ttl        = null
    },
    {
      subdomain  = "loadbalancer-ip"
      ip_address = "172.0.0.1"
      type       = "A"
      proxied    = false
      ttl        = null
    },
  ]
}

module "dns_record" {
  source          = "../modules"
  count           = length(local.dns_records)
  zone_id         = "your-zone-id"
  name            = local.dns_records[count.index].subdomain
  type            = local.dns_records[count.index].type
  comment         = "environment with DNS records configured by Terraform."
  allow_overwrite = false
  records = [{
    value   = local.dns_records[count.index].ip_address
    proxied = local.dns_records[count.index].proxied
    ttl     = local.dns_records[count.index].ttl
  }]
}
