resource "google_compute_security_policy" "cloud_armor" {
  adaptive_protection_config {
    layer_7_ddos_defense_config {
      enable = true
    }
  }
  name = var.name
  type = var.type

  dynamic "rule" {
    for_each = var.rules_src_ip_ranges
    iterator = rule
    content {
      action   = rule.value.action
      priority = rule.value.priority
      match {
        versioned_expr = "SRC_IPS_V1"
        config {
          src_ip_ranges = rule.value.ranges
        }
      }
      description = rule.value.description
    }
  }

  dynamic "rule" {
    for_each = var.rules_expression
    iterator = rule
    content {
      action   = rule.value.action
      priority = rule.value.priority
      match {
        expr {
          expression = rule.value.expression
        }
      }
      description = rule.value.description
    }
  }
}
