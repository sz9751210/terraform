resource "cloudflare_record" "dns_records" {
  for_each        = { for idx, rec in var.records : idx => rec }
  zone_id         = var.zone_id
  name            = var.name
  type            = var.type
  comment         = var.comment
  allow_overwrite = var.allow_overwrite
  value           = each.value.value
  ttl             = each.value.ttl
  proxied         = each.value.proxied
}


output "dns_records_details" {
  value = [for r in cloudflare_record.dns_records : {
    address = r.value
    name    = r.name
    type    = r.type
    ttl     = r.ttl
    proxied = r.proxied
  }]
}
