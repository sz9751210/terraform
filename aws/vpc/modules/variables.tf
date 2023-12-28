variable "main_vpc_cidr" {
  type = string
}

variable "prefix" {
  type = string
}

variable "public_subnets_cidr" {
  type = list(string)
}

variable "private_subnets_cidr" {
  type = list(string)
}

variable "azs" {
  type = list(string)
}

variable "region" {
  type = string
}
