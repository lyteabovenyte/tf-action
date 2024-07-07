variable "namespace" {
    type = string
}

variable "ssh_keypair" {
    type = string
}

variable "vpc" {
    type = any
}

variable "sg" {
    type = any
}

variable "db-config" {
    type = object({
      user = string
      password = string
      database = string
      hostname = string
      port = string
    })
}