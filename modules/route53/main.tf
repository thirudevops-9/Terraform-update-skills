# Get existing hosted zone details
data "aws_route53_zone" "hosted_zone" {
  name = var.domain_name
}

# Create a record set in Route 53


resource "aws_route53_record" "node_ec2" {
  zone_id = data.aws_route53_zone.hosted_zone.zone_id
  name    = var.subdomain_name
  type    = "CNAME"
  ttl     = "300"
  records = [var.alb_dns_name]
}




