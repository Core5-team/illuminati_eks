provider "kubernetes" {
  host                   = var.cluster_endpoint
  token                  = var.cluster_token
  cluster_ca_certificate = var.cluster_certificate_authority
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

resource "aws_iam_openid_connect_provider" "eks" {
  url = var.oidc_issuer
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = ["D7D10AC1FD7E87F1A3787A9A8BE9B0F8538EC059"]
}

data "aws_iam_policy_document" "irsa_trust" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
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

resource "kubernetes_service_account" "backend" {
  metadata {
    name      = var.service_account_name
    namespace = var.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.irsa_role.arn
    }
  }
}

resource "kubernetes_secret" "s3_config" {
  metadata {
    name      = "s3-config"
    namespace = var.namespace
  }

  data = {
    AWS_S3_BUCKET_NAME = aws_s3_bucket.bucket.bucket
    AWS_S3_REGION      = var.aws_region
  }

  type = "Opaque"
}
