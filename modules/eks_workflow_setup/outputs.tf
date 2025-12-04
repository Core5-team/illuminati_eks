output "name-servers" {
  value = aws_route53_zone.main.name_servers
}

output "acm_certificate_arn" {
  value       = aws_acm_certificate.main.arn
  description = "ARN of the ACM certificate"
}