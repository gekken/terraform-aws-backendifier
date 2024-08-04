terraform {
  required_version = ">=1.9.0, <2.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.60.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.profile

  default_tags {
    tags = {
      Terraform = "true"
    }
  }
}
