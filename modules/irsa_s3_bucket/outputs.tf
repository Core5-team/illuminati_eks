output "irsa_role_arn" {
  value = aws_iam_role.irsa_role.arn
}

output "s3_bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}
