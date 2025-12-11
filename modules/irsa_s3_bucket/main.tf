provider "kubernetes" {
  host                   = var.cluster_endpoint
  token                  = var.cluster_token
  cluster_ca_certificate = base64decode(var.cluster_certificate_authority)
}

locals {
  oidc_host = replace(var.oidc_issuer, "https://", "")
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name = var.bucket_name
  }
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "irsa_trust" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${local.oidc_host}"]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_host}:sub"
      values   = ["system:serviceaccount:${var.namespace}:${var.service_account_name}"]
    }
  }
}

resource "aws_iam_role" "irsa_role" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.irsa_trust.json
}

resource "aws_iam_role_policy" "s3_policy" {
  name   = "${var.role_name}-s3-policy"
  role   = aws_iam_role.irsa_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = ["s3:GetObject","s3:PutObject","s3:DeleteObject","s3:ListBucket"],
      Resource = [
        aws_s3_bucket.bucket.arn,
        "${aws_s3_bucket.bucket.arn}/*"
      ]
    }]
  })
}


resource "kubernetes_config_map" "backend_irsa" {
  depends_on = [
    aws_iam_role.irsa_role
  ]

  metadata {
    name      = "backend-irsa"
    namespace = "illuminati"
  }

  data = {
    irsaRoleArn = aws_iam_role.irsa_role.arn
  }
}
