resource "aws_eks_addon" "pod_identity" {
  cluster_name  = var.cluster_name
  addon_name    = "eks-pod-identity-agent"
  addon_version = "v1.3.9-eksbuild.5"
}

resource "aws_eks_addon" "metric_server" {
  cluster_name  = var.cluster_name
  addon_name    = "metrics-server"
  addon_version = "v0.8.0-eksbuild.3"
  depends_on    = [aws_eks_addon.pod_identity]
}

resource "aws_eks_addon" "cert_manager" {
  cluster_name  = var.cluster_name
  addon_name    = "cert-manager"
  addon_version = "v1.19.1-eksbuild.1"
  depends_on    = [aws_eks_addon.metric_server]
}

resource "aws_eks_addon" "external_dns" {
  cluster_name  = var.cluster_name
  addon_name    = "external-dns"
  addon_version = "v0.19.0-eksbuild.3"
  depends_on    = [helm_release.aws_loadbalancer_controller]
}

