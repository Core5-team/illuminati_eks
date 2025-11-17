module "eks_setup" {
  source = "./modules/eks_setup"
  #---------------------------------------------------------availability_zones&subnet_cidr_blocks
  cluster_availability_zone_1 = var.cluster_availability_zone_1
  cluster_availability_zone_2 = var.cluster_availability_zone_2
  private_subnet_cidr_block_1 = var.private_subnet_cidr_block_1
  private_subnet_cidr_block_2 = var.private_subnet_cidr_block_2
  public_subnet_cidr_block_1  = var.public_subnet_cidr_block_1
  public_subnet_cidr_block_2  = var.public_subnet_cidr_block_2
  #---------------------------------------------------------node_group_autoscaling_config---------
  min_size     = var.min_size
  max_size     = var.max_size
  desired_size = var.desired_size
  #---------------------------------------------------------cluster_config_vars-------------------
  eks_cluster_name        = var.eks_cluster_name
  environment_name        = var.environment_name
  eks_cluster_k8s_version = var.eks_cluster_k8s_version
  #---------------------------------------------------------nodes_config_vars---------------------
  node_instance_types = var.node_instance_types
  #---------------------------------------------------------workflow_setup------------------------
  vpc_id                = var.vpc_id
  public_route_table_id = var.public_route_table_id
}

module "eks_workflow_setup" {
  source                        = "./modules/eks_workflow_setup"
  cluster_endpoint              = module.eks_setup.cluster_endpoint
  cluster_certificate_authority = module.eks_setup.cluster_certificate_authority
  cluster_token                 = module.eks_setup.cluster_token
  cluster_name                  = module.eks_setup.cluster_name
}
