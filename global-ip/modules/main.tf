resource "google_compute_global_address" "global_ip" {
  for_each     = var.addresses
  name         = each.key
  address_type = each.value.address_type
  ip_version   = each.value.ip_version

  lifecycle {
    prevent_destroy = true
  }
}
