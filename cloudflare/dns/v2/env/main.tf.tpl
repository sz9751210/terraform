module "${PROD_ENV}_${ENV}_redis_cname_record" {
  source  = "../modules"
  zone_id = "${ZONE_ID}"
  records = [
    {
      name    = "redis-0"
      type    = "CNAME"
      value   = "${REDIS_SERVICE_0_DNS_NAME}"
      ttl     = null
      proxied = false
    },
    {
      name    = "redis-1"
      type    = "CNAME"
      value   = "${REDIS_SERVICE_1_DNS_NAME}"
      ttl     = null
      proxied = false
    },
    {
      name    = "redis-2"
      type    = "CNAME"
      value   = "${REDIS_SERVICE_2_DNS_NAME}"
      ttl     = null
      proxied = false
    }
  ]
  comment         = "EKS ${PROD_ENV} ${ENV} redis environment with DNS records configured by Terraform."
  allow_overwrite = false
}

module "${PROD_ENV}_${ENV}_redis_sentinal_cname_record" {
  source  = "../modules"
  zone_id = "${ZONE_ID}"
  records = [
    {
      name    = "redis-sentinel-0"
      type    = "CNAME"
      value   = "${REDIS_SENTINEL_SERVICE_0_DNS_NAME}"
      ttl     = null
      proxied = false
    },
    {
      name    = "redis-sentinel-1"
      type    = "CNAME"
      value   = "${REDIS_SENTINEL_SERVICE_1_DNS_NAME}"
      ttl     = null
      proxied = false
    },
    {
      name    = "redis-sentinel-2"
      type    = "CNAME"
      value   = "${REDIS_SENTINEL_SERVICE_2_DNS_NAME}"
      ttl     = null
      proxied = false
    }
  ]
  comment         = "EKS ${PROD_ENV} ${ENV} redis-sentinel environment with DNS records configured by Terraform."
  allow_overwrite = false
}
