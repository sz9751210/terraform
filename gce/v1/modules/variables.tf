variable "region" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "resource_tags" {
  type = list(string)
}

variable "image" {
  type = string
}

variable "boot_disk_type" {
  type = string
}

variable "boot_disk_size" {
  type = number
}

variable "vpc_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "labels" {
  type = map(string)
}

variable "servers" {
  type = map(any)
}
