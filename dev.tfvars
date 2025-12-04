#--------------------------------------------------------- Availability Zones

cluster_availability_zone_1 = "us-east-1a"  
cluster_availability_zone_2 = "us-east-1b"
private_subnet_cidr_block_1 = "10.0.10.0/24" 
private_subnet_cidr_block_2 = "10.0.11.0/24"
public_subnet_cidr_block_1  = "10.0.12.0/24"
public_subnet_cidr_block_2  = "10.0.13.0/24"

#--------------------------------------------------------- Node Group Autoscaling Config

min_size     = 1
max_size     = 5
desired_size = 1

#--------------------------------------------------------- Cluster Configuration Variables

eks_cluster_name        = "illuminati_app_cluster" # Like illuminati_app_cluster
environment_name        = "dev" # Like dev, stage or prod
eks_cluster_k8s_version = "1.34"

#--------------------------------------------------------- Nodes Configuration Variables

node_instance_types = ["t3.small"]

#--------------------------------------------------------- Workflow Setup

region                = "us-east-1" # Like eu-central-1
vpc_id                = "vpc-01801d31a7562ff18" # Like vpc-xxxxxxxxxxxxxxxxx
public_route_table_id = "rtb-00ac9dff63f298749" # Like rtb-xxxxxxxxxxxxxxxxx
domain_name           = "illuminati-core5.pp.ua" # Like example.com
existing_nat_gateway_id = "nat-0354fb0a689f7d188"

#--------------------------------------------------------- Database Setup

db_username         = "dev_user" # The username should be between 1 and 16 characters.
db_password         = "asdASD123456" # The password should consist of at least 8 characters.
db_private_subnet_1 = "10.0.14.0/24" 
db_private_subnet_2 = "10.0.15.0/24"
