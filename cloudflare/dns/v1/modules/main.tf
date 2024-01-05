locals {
  records = [for record in var.records : {
    value   = lookup(record, "value", null)
    proxied = lookup(record, "proxied", null)
    ttl     = lookup(record, "ttl", null)
  }]
}

resource "cloudflare_record" "record" {
  count           = length(local.records)
  zone_id         = var.zone_id
  name            = var.name
  type            = var.type
  comment         = var.comment
  allow_overwrite = var.allow_overwrite
  value           = local.records[count.index].value
  proxied         = local.records[count.index].proxied
  ttl             = local.records[count.index].ttl
}
