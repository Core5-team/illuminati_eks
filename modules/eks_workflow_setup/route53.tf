resource "aws_route53_zone" "main" {
  name = var.domain_name

  tags = {
    Environment = var.environment_name
    Name        = "${var.cluster_name}-zone"
  }
  lifecycle {
    prevent_destroy = true 
  }
}

data "aws_iam_policy_document" "external_dns_assume" {
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

resource "aws_iam_role" "external_dns" {
  name               = "${var.cluster_name}-external-dns"
  assume_role_policy = data.aws_iam_policy_document.external_dns_assume.json
}

resource "aws_iam_policy" "external_dns" {
  name = "${var.cluster_name}-external-dns-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["route53:ChangeResourceRecordSets"]
        Resource = aws_route53_zone.main.arn
      },
      {
        Effect = "Allow"
        Action = [
          "route53:ListHostedZones",
          "route53:ListResourceRecordSets",
          "route53:ListTagsForResource"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "external_dns" {
  role       = aws_iam_role.external_dns.name
  policy_arn = aws_iam_policy.external_dns.arn
}

resource "aws_eks_pod_identity_association" "external_dns" {
  cluster_name    = var.cluster_name
  namespace       = "kube-system"
  service_account = "external-dns"
  role_arn        = aws_iam_role.external_dns.arn
}