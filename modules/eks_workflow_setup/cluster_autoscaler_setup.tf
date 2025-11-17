data "aws_iam_policy_document" "cluster_autoscaler_document" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "cluster_autoscaler_role" {
  name               = "${var.cluster_name}-cluster-autoscaler"
  assume_role_policy = data.aws_iam_policy_document.cluster_autoscaler_document.json
}

resource "aws_iam_policy" "cluster_autoscaler_policy" {
  name = "${aws_iam_role.cluster_autoscaler_role.name}-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "autoscaling:DescribeAutoScalingGroups",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeLaunchConfigurations",
          "autoscaling:DescribeScalingActivities",
          "ec2:DescribeImages",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeLaunchTemplateVersions",
          "ec2:GetInstanceTypesFromInstanceRequirements",
          "eks:DescribeNodegroup"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "autoscaling:SetDesiredCapacity",
          "autoscaling:TerminateInstanceInAutoScalingGroup"
        ]
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler_policy_attachment" {
  role       = aws_iam_role.cluster_autoscaler_role.name
  policy_arn = aws_iam_policy.cluster_autoscaler_policy.arn

}

resource "aws_eks_pod_identity_association" "cluster_autoscaler" {
  cluster_name    = var.cluster_name
  namespace       = "kube-system"
  service_account = "cluster-autoscaler"
  role_arn        = aws_iam_role.cluster_autoscaler_role.arn
}

#TODO
resource "helm_release" "cluster_autoscaler" {
  name = "autoscaler"

  repository = ""
  chart      = "cluster_autoscaler"
  version    = "0.1.0"
  namespace  = "kube-system"

  set = [{
    name  = "serviceAccountName"
    value = "cluster-autoscaler"
    },
    {
      name  = "clusterName"
      value = var.cluster_name
  }]
}
