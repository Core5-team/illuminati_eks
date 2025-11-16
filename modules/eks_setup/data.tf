data "aws_eks_cluster_auth" "cluster_auth" {
  name = aws_eks_cluster.eks.name
}
