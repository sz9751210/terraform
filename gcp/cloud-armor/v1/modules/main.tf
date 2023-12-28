resource "google_compute_security_policy" "main" {
  adaptive_protection_config {
    layer_7_ddos_defense_config {
      enable = true
    }
  }
  name = var.name
  type = var.type

  dynamic "rule" {
    for_each = var.rules_allow
    iterator = allow
    content {
      action   = "allow"
      priority = allow.value.priority
      match {
        versioned_expr = "SRC_IPS_V1"
        dynamic "config" {
          for_each = allow.value.ranges != null ? [1] : []
          content {
            src_ip_ranges = allow.value.ranges
          }
        }
      }
      description = allow.value.description
    }
  }

  dynamic "rule" {
    for_each = var.rules_deny
    iterator = deny
    content {
      action   = "deny(403)"
      priority = deny.value.priority

      dynamic "match" {
        for_each = deny.value.ranges != null ? [1] : []
        content {
          versioned_expr = "SRC_IPS_V1"
          config {
            src_ip_ranges = deny.value.ranges
          }
        }
      }
      description = deny.value.description

      dynamic "match" {
        for_each = deny.value.expression != null ? [1] : []
        content {
          expr {
            expression = deny.value.expression
          }
        }
      }
    }
  }
}
