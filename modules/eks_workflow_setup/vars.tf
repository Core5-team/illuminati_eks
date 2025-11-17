variable "cluster_endpoint" {
  description = "Cluster endpoint porvided po int the EKS cluster to which we are going to connect"
  type        = string

}

variable "cluster_certificate_authority" {
  description = "Cluster certificate authirity"
  type        = string
}

variable "cluster_token" {
  description = "Cluster token for authirization to eks cluster"
  type        = string
}

variable "cluster_name" {
  description = "Cluster name to parse in helm chart"
  type        = string
}

variable "region" {
  description = "The region tag where our eks cluster will be deployed"
  type        = string
}
