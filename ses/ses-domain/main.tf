resource "aws_ses_domain_identity" "ses_domain" {
  domain = var.domain_name
}

resource "aws_route53_record" "ses_verification_record" {
  zone_id = var.route53_zone_id
  name    = "_amazonses.${aws_ses_domain_identity.ses_domain.id}"
  type    = "TXT"
  ttl     = var.route53_ttl
  records = [aws_ses_domain_identity.ses_domain.verification_token]
}

resource "aws_ses_domain_identity_verification" "ses_verification" {
  domain = aws_ses_domain_identity.ses_domain.id

  depends_on = [aws_route53_record.ses_verification_record]
}