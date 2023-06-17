terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4"
    }
  }
}

variable "vpc_name" {
  type = "convert-existing-vpc"
}

module "vpc" {
  source = "../modules/vpc"
  name = var.vpc_name
}