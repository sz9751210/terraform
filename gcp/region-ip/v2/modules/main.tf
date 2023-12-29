resource "google_compute_address" "dynamic_addresses" {
  for_each = { for addr in var.addresses : addr.name => addr }
  name          = each.value.name
  address_type  = each.value.address_type
  network_tier  = "PREMIUM"
  region        = each.value.region
}