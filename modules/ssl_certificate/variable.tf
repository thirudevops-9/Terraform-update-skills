variable "domain_name" {
  description = "The domain name for which the SSL certificate is required"
  type        = string
}

variable "subject_alternative_names" {
  description = "Additional FQDNs to be included in the SSL certificate"
  type        = list(string)
  default     = []
}

variable "route53_zone_id" {
  description = "The Route 53 Hosted Zone ID"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}

# variable "tags" {
#   description = "A map of tags to assign to the resource"
#   type        = map(string)
#   default     = {}
# }
