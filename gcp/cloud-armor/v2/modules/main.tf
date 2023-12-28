resource "google_compute_security_policy" "cloud_armor" {
  adaptive_protection_config {
    layer_7_ddos_defense_config {
      enable = true
    }
  }
  name = var.name
  type = var.type

  dynamic "rule" {
    for_each = var.rules_allow_src_ip_ranges
    iterator = allow
    content {
      action   = "allow"
      priority = allow.value.priority
      match {
        versioned_expr = "SRC_IPS_V1"
        config {
          src_ip_ranges = allow.value.ranges
        }
      }
      description = allow.value.description
    }
  }

  dynamic "rule" {
    for_each = var.rules_allow_expression
    iterator = allow
    content {
      action   = "allow"
      priority = allow.value.priority
      match {
        expr {
          expression = allow.value.expression
        }
      }
      description = allow.value.description
    }
  }

  dynamic "rule" {
    for_each = var.rules_deny_src_ip_ranges
    iterator = deny
    content {
      action   = "deny(403)"
      priority = deny.value.priority
      match {
        versioned_expr = "SRC_IPS_V1"
        config {
          src_ip_ranges = deny.value.ranges
        }
      }
      description = deny.value.description
    }
  }

  dynamic "rule" {
    for_each = var.rules_deny_expression
    iterator = deny
    content {
      action   = "deny(403)"
      priority = deny.value.priority
      match {
        expr {
          expression = deny.value.expression
        }
      }
      description = deny.value.description
    }
  }
}
