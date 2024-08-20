variable "domain_name" {
  
}

variable "subdomain_name" {
  
}

variable "alb_zone_id" {
  
}
variable "alb_dns_name" {
  
}


variable "record_name" {
  description = "The name of the DNS record"
  type        = string
}

variable "cname_target" {
  description = "The target of the CNAME record"
  type        = string
}
