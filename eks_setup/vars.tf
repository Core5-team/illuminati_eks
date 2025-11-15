#---------------------------------------------------------availability_zones

variable "cluster_availability_zone_1" {
  type    = string
  default = "eu-central-1a"
}

variable "cluster_availability_zone_2" {
  type    = string
  default = "eu-central-1b"
}

#---------------------------------------------------------subnet_cidr_blocks

variable "private_subnet_cidr_block_1" {
  type    = string
  default = "10.0.2.0/24"
}

variable "private_subnet_cidr_block_2" {
  type    = string
  default = "10.0.3.0/24"
}

variable "public_subnet_cidr_block_2" {
  type    = string
  default = "10.0.4.0/24"
}

variable "public_subnet_cidr_block_1" {
  type    = string
  default = "10.0.5.0/24"
}

#---------------------------------------------------------node_group_autoscaling_config

variable "min_size" {
  description = "Minimum number of nodes to have in the EKS cluster"
  type        = number
  default     = 1
}
variable "max_size" {
  description = "Maximum number of nodes to have in the EKS cluster"
  type        = number
  default     = 5
}

variable "desired_size" {
  description = "Desired number of nodes to have in the EKS cluster"
  type        = number
  default     = 1
}

#---------------------------------------------------------cluster_config_vars

variable "eks_cluster_name" {
  description = "The name to use for the EKS cluster"
  type        = string
  default     = "illuminati_app_cluster"
}

variable "environment_name" {
  description = "The name of environment where the EKS cluster will be created"
  type        = string
  default     = "dev"
}

variable "eks_cluster_k8s_version" {
  description = "The kubernetes version that will be used for our cluster"
  type        = string
  default     = "1.34"
}

#---------------------------------------------------------nodes_config_vars

variable "node_instance_types" {
  description = "The types of EC2 instances to run in the node group"
  type        = list(string)
  default     = ["t3.small"]
}
