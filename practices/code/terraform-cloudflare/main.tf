module "cloudflare_dns_records" {
  source               = "./modules"
  zone_id              = "your-zone-id"
  cloudflare_api_token = "your-api-token"
  name                 = "terraform"
  type                 = "A"
  comment              = "Managed by Terraform"
  allow_overwrite      = false
  records = [{
    value   = data.terraform_remote_state.global_ip.outputs.global_ip_info.address
    proxied = false
    ttl     = null
    }
  ]
}
