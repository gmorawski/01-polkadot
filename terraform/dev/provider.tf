provider "aws" {
  region  = "eu-central-1"
  profile = "navid"
}

terraform {
  required_version = ">=1.0"

  # Note: For testing purpose I have used the local backend. This should be changed to s3 bucket.
  backend "local" {
    path = "dev/terraform.tfstate"
  }
}
