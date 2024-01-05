variable "zone_id" {
  type = string
}

variable "comment" {
  type = string
}

variable "allow_overwrite" {
  type = bool
}

variable "records" {
  type = list(object
    (
      {
        name    = string
        type    = string
        value   = string
        proxied = optional(bool, false)
        ttl     = optional(number, 1)
      }
    )
  )
}
