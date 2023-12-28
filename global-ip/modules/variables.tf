variable "addresses" {
  default = {}
  type = map(object({
    address_type = string
    ip_version   = string
  }))
}
