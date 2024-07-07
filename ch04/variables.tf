variable "namespace" {
    description = "the project namespace to use for unique resource naming"
    type = string
}

variable "ssh_keypair" {
    description = "ssh keypair to use for EC2 instance"
    type = string
    default = null
}

variable "region" {
    description = "AWS region"
    type = string
    default = "us-west-2"
}