variable "cluster_endpoint" {
  description = "Cluster endpoint reference to the EKS cluster to which we are going to connect"
  type        = string

}

variable "cluster_certificate_authority" {
  description = "Cluster certificate authority"
  type        = string
}

variable "cluster_token" {
  description = "Cluster token for authorization to the EKS cluster"
  type        = string
}

variable "cluster_name" {
  description = "Cluster name to parse in the Helm chart"
  type        = string
}

variable "region" {
  description = "The region tag where our EKS cluster will be deployed"
  type        = string
}

variable "vpc_id" {
  description = "The id of vpc where our application will be deployed"
  type        = string
}

variable "domain_name" {
  description = "Domain name for Route53 hosted zone"
  type        = string
}

variable "environment_name" {
  description = "Environment name (dev, stage, prod)"
  type        = string
}