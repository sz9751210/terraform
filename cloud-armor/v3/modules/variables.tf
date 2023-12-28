variable "name" {
  type = string
}

variable "project" {
  type = string
}

variable "type" {
  type = string
}

variable "rules_src_ip_ranges" {
  default = []
  type = list(object
    (
      {
        action      = string
        priority    = number
        ranges      = list(string)
        description = string
      }
    )
  )
}

variable "rules_expression" {
  default = []
  type = list(object
    (
      {
        action      = string
        priority    = number
        expression  = string
        description = string
      }
    )
  )
}
