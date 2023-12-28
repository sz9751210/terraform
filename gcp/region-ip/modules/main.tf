resource "google_compute_address" "region_ip" {
  count        = length(var.addresses)
  name         = var.addresses[count.index].name
  address_type = var.addresses[count.index].address_type
  network_tier = "PREMIUM"
  region       = var.addresses[count.index].region
}
