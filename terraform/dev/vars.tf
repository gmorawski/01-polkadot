variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-central-1"
}

variable "env" {
  type    = string
  default = "dev"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "ami" {
  description = "Ubuntu 22.04 LTS ami"
  type    = string
  default = "ami-04e601abe3e1a910f"
}