variable "name" {
  type = string
}

variable "project" {
  type = string
}

variable "type" {
  type = string
}

variable "rules_allow_src_ip_ranges" {
  default = []
  type = list(object
    (
      {
        priority    = number
        ranges      = list(string)
        description = string
      }
    )
  )
}

variable "rules_allow_expression" {
  default = []
  type = list(object
    (
      {
        priority    = number
        expression  = string
        description = string
      }
    )
  )
}

variable "rules_deny_src_ip_ranges" {
  default = []
  type = list(object
    (
      {
        priority    = number
        ranges      = list(string)
        description = string
      }
    )
  )
}

variable "rules_deny_expression" {
  default = []
  type = list(object
    (
      {
        priority    = number
        expression  = string
        description = string
      }
    )
  )
}
