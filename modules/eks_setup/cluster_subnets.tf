resource "aws_subnet" "private_zone1" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr_block_1
  availability_zone = var.cluster_availability_zone_1

  tags = {
    "Name"                                                                  = "${var.environment_name}-${var.eks_cluster_name}-private-${var.cluster_availability_zone_1}"
    "kubernetes.io/role/internal-elb"                                       = "1"
    "kubernetes.io/cluster/${var.environment_name}-${var.eks_cluster_name}" = "owned"
  }
}

resource "aws_subnet" "private_zone2" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnet_cidr_block_2
  availability_zone = var.cluster_availability_zone_2

  tags = {
    "Name"                                                                  = "${var.environment_name}-${var.eks_cluster_name}-private-${var.cluster_availability_zone_2}"
    "kubernetes.io/role/internal-elb"                                       = "1"
    "kubernetes.io/cluster/${var.environment_name}-${var.eks_cluster_name}" = "owned"
  }
}

resource "aws_subnet" "public_zone1" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidr_block_1
  availability_zone       = var.cluster_availability_zone_1
  map_public_ip_on_launch = true

  tags = {
    "Name"                                                                  = "${var.environment_name}-${var.eks_cluster_name}-public-${var.cluster_availability_zone_1}"
    "kubernetes.io/role/elb"                                                = "1"
    "kubernetes.io/cluster/${var.environment_name}-${var.eks_cluster_name}" = "owned"
  }
}

resource "aws_subnet" "public_zone2" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnet_cidr_block_2
  availability_zone       = var.cluster_availability_zone_2
  map_public_ip_on_launch = true

  tags = {
    "Name"                                                                  = "${var.environment_name}-${var.eks_cluster_name}-public-${var.cluster_availability_zone_2}"
    "kubernetes.io/role/elb"                                                = "1"
    "kubernetes.io/cluster/${var.environment_name}-${var.eks_cluster_name}" = "owned"
  }
}
