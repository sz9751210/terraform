module "cloud_armor" {
  source  = "../modules"
  name    = "cloud-armor"
  project = "your-project-id"
  type    = "CLOUD_ARMOR"

  rules_allow = [
    {
      priority    = 1000
      ranges      = ["127.0.0.1/32", "10.0.0.0/8"]
      expression  = null
      description = "internal IP"
    },
    {
      priority    = 999
      ranges      = ["33.44.55.66/32"]
      expression  = null
      description = "external IP"
    }
  ]
  rules_deny = [
    {
      priority    = 2147483647
      ranges      = ["*"]
      expression  = null
      description = "Default rule, higher priority overrides it"
    }
  ]
}
