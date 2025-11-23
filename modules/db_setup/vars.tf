#-----------------------------------------------------------------------------------HELM&K8S

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

variable "private_cluster_cidr_block_1" {
  description = "Subnet of eks nodes"
  type        = string
}

variable "private_cluster_cidr_block_2" {
  description = "Subnet of eks nodes"
  type        = string
}


#-----------------------------------------------------------------------------------RDS_VARS

variable "db_username" {
  description = "An username for master user of RDS db"
  type        = string
}

variable "db_password" {
  description = "A password for master user of RDS db"
  type        = string
}

variable "region" {
  description = "A region tag where our RDS cluster will be deployed"
  type        = string
}

variable "vpc_id" {
  description = "The id of vpc where our application will be deployed"
  type        = string
}

variable "public_route_table_id" {
  description = "The id of the public route table where our nat and elb will be deployed"
  type        = string
}

variable "db_private_subnet_1" {
  description = "Private subnet for RDS"
  type        = string
}

variable "db_private_subnet_2" {
  description = "Private subnet for RDS"
  type        = string
}

variable "db_availability_zone_1" {
  description = "One of availability zones where our nodes will be created"
  type        = string
}

variable "db_availability_zone_2" {
  description = "One of availability zones where our nodes will be created"
  type        = string
}

