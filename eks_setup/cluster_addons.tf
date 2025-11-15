resource "aws_eks_addon" "pod_identity" {
  cluster_name  = aws_eks_cluster.eks.name
  addon_name    = "eks-pod-identity-agent"
  addon_version = "v1.3.9-eksbuild.5"
}

resource "aws_eks_addon" "metric_server" {
  cluster_name  = aws_eks_cluster.eks.name
  addon_name    = "metrics-server"
  addon_version = "v0.8.0-eksbuild.3"
}
