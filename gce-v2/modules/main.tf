resource "google_compute_address" "ip" {
  for_each     = { for server in var.servers : server.name => server }
  name         = "${each.value.name}-ip"
  address_type = "INTERNAL"
  subnetwork   = var.subnet_name
  address      = each.value.ip
  region       = var.region
}

resource "google_compute_instance" "server" {
  for_each     = { for server in var.servers : server.name => server }
  name         = each.value.name
  zone         = each.value.zone
  machine_type = var.machine_type
  tags         = var.resource_tags
  labels       = var.labels

  boot_disk {
    initialize_params {
      image = var.image
      type  = var.boot_disk_type
      size  = var.boot_disk_size
    }
  }

  network_interface {
    network    = var.vpc_name
    subnetwork = var.subnet_name
    network_ip = google_compute_address.ip[each.key].address
  }
}
