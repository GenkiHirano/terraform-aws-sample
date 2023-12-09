output "domain_name" {
  value = aws_route53_record.this.name
}

output "acm_certificate_arn" {
  value = aws_acm_certificate.this.arn
}
