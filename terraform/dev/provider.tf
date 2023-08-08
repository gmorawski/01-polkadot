provider "aws" {
  region  = "eu-central-1"
  profile = "navid"
}

terraform {
  required_version = ">=1.0"

  backend "local" {
    path = "dev/terraform.tfstate"
  }
}