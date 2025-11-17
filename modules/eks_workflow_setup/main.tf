provider "aws" {
  region = var.region
}

provider "helm" {
  kubernetes = {
    host                   = var.cluster_endpoint
    cluster_ca_certificate = var.cluster_certificate_authority
    token                  = var.cluster_token
    load_config_file       = false
  }
}


terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}
