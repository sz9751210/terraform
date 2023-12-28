module "loadbalancer_global_ip" {
  source = "../modules"
  addresses = {
    "loadbalancer-global-ip" = {
      address_type = "EXTERNAL"
      ip_version   = "IPV4"
    }
  }
}

module "ingress_global_ip" {
  source = "../modules"
  addresses = {
    "ingress-global-ip" = {
      address_type = "EXTERNAL"
      ip_version   = "IPV4"
    }
  }
}
