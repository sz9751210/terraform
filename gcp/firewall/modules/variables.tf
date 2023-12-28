variable "region" {
  type    = string
  description = "The region where the firewall rule will be created"
}

variable "name" {
  type    = string
  description = "The name of the firewall rule"
}

variable "network" {
  type    = string
  description = "The name of the network"
}

variable "ranges" {
  type    = list(string)
  description = "The source IP ranges"
}

variable "target_tags" {
  type    = list(string)
  description = "The target tags"
}

variable "priority" {
  type    = string
  description = "The priority of the firewall rule"
}

variable "rules_allow" {
  default = []
  type    = list(object({
    protocol = string
    ports    = list(string)
  }))
  description = "The list of allowed rules"
}

variable "rules_deny" {
  default = []
  type    = list(object({
    protocol = string
    ports    = list(string)
  }))
  description = "The list of deny rules"
}
