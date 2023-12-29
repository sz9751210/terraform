variable "project_region" {
  type = string
}

variable "addresses" {
  default = []
  type = list(object({
    name         = string
    address_type = string
    region       = string
  }))
}
