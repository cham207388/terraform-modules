terraform {
  required_version = ">= 1.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.72.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.4.2"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.9.1"
    }
  }
}

provider "aws" {}

module "ec2" {
  source = "./ec2"
}
