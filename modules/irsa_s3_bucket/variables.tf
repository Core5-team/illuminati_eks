variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket to create"
}

variable "namespace" {
  type        = string
  default     = "default"
}

variable "service_account_name" {
  type        = string
  description = "K8s service account name that will assume the role"
}

variable "role_name" {
  type        = string
  description = "Name of the IAM role for IRSA"
}

variable "oidc_issuer" {
  description = "OIDC issuer URL of the EKS cluster"
  type        = string
}

variable "region" {
  type        = string
  description = "AWS region for the S3 bucket"
}

variable "cluster_endpoint" {}
variable "cluster_certificate_authority" {}
variable "cluster_token" {}
