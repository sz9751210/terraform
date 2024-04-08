variable "cloudflare_api_token" {
  type = string
}

variable "zone_id" {
  type = string
}

variable "name" {
  type = string
}

variable "type" {
  type = string
}

variable "comment" {
  type = string
}

variable "allow_overwrite" {
  type = bool
}

variable "records" {
  type = list(object({
    value   = optional(string)
    proxied = optional(bool)
    ttl     = optional(number, 1)
  }))
}
