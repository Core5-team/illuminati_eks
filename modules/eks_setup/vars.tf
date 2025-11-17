#---------------------------------------------------------availability_zones

variable "cluster_availability_zone_1" {
  description = "One of availability zones where our nodes will be created"
  type        = string
}

variable "cluster_availability_zone_2" {
  description = "One of availability zones where our nodes will be created"
  type        = string
}

#---------------------------------------------------------subnet_cidr_blocks

variable "private_subnet_cidr_block_1" {
  description = "Subnet for our nodes"
  type        = string
}

variable "private_subnet_cidr_block_2" {
  description = "Subnet for our nodes"
  type        = string
}

variable "public_subnet_cidr_block_1" {
  description = "Subnet for nat to let for our node connect to the internet"
  type        = string
}


variable "public_subnet_cidr_block_2" {
  description = "Subnet for ELB which will be later connected to ingress controller"
  type        = string
}

#---------------------------------------------------------node_group_autoscaling_config

variable "min_size" {
  description = "Minimum number of nodes to have in the EKS cluster"
  type        = number
}
variable "max_size" {
  description = "Maximum number of nodes to have in the EKS cluster"
  type        = number
}

variable "desired_size" {
  description = "Desired number of nodes to have in the EKS cluster"
  type        = number
}

#---------------------------------------------------------cluster_config_vars

variable "eks_cluster_name" {
  description = "The name to use for the EKS cluster"
  type        = string
}

variable "environment_name" {
  description = "The name of environment where the EKS cluster will be created"
  type        = string
}

variable "eks_cluster_k8s_version" {
  description = "The kubernetes version that will be used for our cluster"
  type        = string
}

#---------------------------------------------------------nodes_config_vars

variable "node_instance_types" {
  description = "The types of EC2 instances to run in the node group"
  type        = list(string)
}

#---------------------------------------------------------workflow_setup

variable "vpc_id" {
  description = "The id of vpc where our application will be deployed"
  type        = string
}

variable "public_route_table_id" {
  description = "The id of the public route table where our nat and elb will be deployed"
  type        = string
}

variable "region" {
  description = "The region tag where our eks cluster will be deployed"
  type        = string
}
