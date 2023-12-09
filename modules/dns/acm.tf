resource "aws_acm_certificate" "this" {
  domain_name = var.domain
  // ドメインを追加したい場合は設定する
  subject_alternative_names = []

  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.this_certificate : record.fqdn]
}
