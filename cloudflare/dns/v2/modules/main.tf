resource "cloudflare_record" "record" {
  for_each = { for r in var.records : r.name => r }
  zone_id         = var.zone_id
  name            = each.value.name
  type            = each.value.type
  value           = each.value.value
  proxied         = each.value.proxied
  ttl             = each.value.ttl
  comment         = var.comment
  allow_overwrite = var.allow_overwrite
}
