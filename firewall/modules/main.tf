resource "google_compute_firewall" "firewall_rule" {
  name          = var.name
  network       = var.network
  source_ranges = var.ranges
  target_tags   = var.target_tags
  priority      = var.priority

  dynamic "allow" {
    for_each = var.rules_allow
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }

  dynamic "deny" {
    for_each = var.rules_deny
    content {
      protocol = deny.value.protocol
      ports    = deny.value.ports
    }
  }
}
