output "certificate_arn" {
  value = aws_acm_certificate_validation.ssl_validation.certificate_arn
}