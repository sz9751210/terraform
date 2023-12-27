module "allow-internal" {
  source      = "../modules"
  region      = "asia-east1"
  name        = "allow-internal"
  network     = "default"
  ranges      = ["127.0.0.1", "10.0.0.0"]
  target_tags = ["allow-internal"]
  priority    = 800

  rules_allow = [
    {
      protocol = "tcp"
      ports    = ["8080", "8081", "8082"]
    },
    {
      protocol = "udp"
      ports    = ["5044"]
    }
  ]
}

module "deny-all" {
  source      = "../modules"
  region      = "asia-east1"
  name        = "deny-all"
  network     = "default"
  ranges      = ["0.0.0.0/0"]
  target_tags = ["deny-all"]
  priority    = 999

  rules_deny = [{
    protocol = "all"
    ports    = []
  }]
}
