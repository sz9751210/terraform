variable "project" {
  type = string
}

variable "name" {
  type = string
}

variable "type" {
  type = string
}

variable "rules_allow" {
  default = []
  type = list(object({
    priority    = number
    ranges      = list(string)
    expression  = string
    description = string
  }))
}

variable "rules_deny" {
  default = []
  type = list(object({
    priority    = number
    ranges      = list(string)
    expression  = string
    description = string
  }))
}
