output "site_domain_record" {
  value = aws_route53_record.node_ec2.name
}

output "subdomain_name" {
  value       = aws_route53_record.node_ec2.name
  description = "The Route 53 record for the subdomain"
}
