provider "aws" {
  region = var.region
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
  }

  backend "s3" {
    bucket  = "terraform-state-illuminati-bucket-frankfurt"
    key     = "eks-setup/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }

}
