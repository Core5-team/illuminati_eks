data "aws_iam_policy_document" "aws_lbc" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_iam_role" "aws_lbc" {
  name               = "${var.cluster_name}-aws-lbc"
  assume_role_policy = data.aws_iam_policy_document.aws_lbc.json
}

resource "aws_iam_policy" "aws_lbc" {
  policy = file("./AWSLoadBalancerController.json")
  name   = "AWSLoadBalancerController"
}

resource "aws_iam_role_policy_attachment" "aws_lbc" {
  policy_arn = aws_iam_policy.aws_lbc.arn
  role       = aws_iam_role.aws_lbc.name
}

resource "aws_eks_pod_identity_association" "aws_lbc" {
  cluster_name    = var.cluster_name
  namespace       = "kube-system"
  service_account = "aws-load-balancer-controller"
  role_arn        = aws_iam_role.aws_lbc.arn
}

resource "null_resource" "cert_manager" {

  provisioner "local-exec" {
    command = "make cert_manager_setup"
    environment = {
      REGION  = join(" ", [var.region])
      CLUSTER = join(" ", [var.cluster_name])
    }

  }

  depends_on = [aws_eks_pod_identity_association.aws_lbc]

}

resource "helm_release" "aws_loadbalancer_controller" {
  name = "aws-loadbalancer-controller"

  repository = "./helm/"
  chart      = "aws_loadbalancer_controller"
  version    = "0.1.0"
  namespace  = "kube-system"

  set = [
    {
      name  = "clusterName"
      value = var.cluster_name
    },
    {
      name  = "clusterVPC"
      value = var.vpc_id
    },
    {
      name  = "clusterRegion"
      value = var.region
    }
  ]

  depends_on = [null_resource.cert_manager]
}
