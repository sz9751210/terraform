module "cloud_armor" {
  source  = "../modules"
  name    = "cloud-armor"
  project = "your-project-id"
  type    = "CLOUD_ARMOR"

  rules_src_ip_ranges = [
    {
      action      = "allow"
      priority    = 1000
      ranges      = ["127.0.0.1/32", "10.0.0.0/8"]
      description = "internal IP"
    },
    {
      action      = "allow"
      priority    = 999
      ranges      = ["33.44.55.66/32"]
      description = "external IP"
    },
    {
      action      = "deny"
      priority    = 2147483647
      ranges      = ["*"]
      expression  = null
      description = "Default rule, higher priority overrides it"
    }
  ]

  rules_expression = [
    {
      action      = "allow"
      priority    = 998
      expression  = "origin.region_code == \"TW\""
      description = "allow TW region code"
    }
  ]
}
