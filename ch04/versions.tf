terraform {
  required_version = ">= 0.15"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 3.28"
    }
    random = {
        source = "hashicorp/random"
        version = "~> 2.0"
    }
    cloudinit = {
        source = "hashicorp/cloudinit"
        version = "~> 2.1"
    }
  }
}