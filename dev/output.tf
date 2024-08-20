# print the Ec2 EIP 

# output "node_public_ip" {
#   value       = module.ec2.ec2_public_ip
#   description = "The public IP address of the EC2 instance."
# }

output "alb_dns_name" {
    value = module.alb.alb_dns_name
    description = "this is the alb dns name"
  
}

output "subdomain_name" {
  value       = module.route53.subdomain_name
  description = "This is the subdomain"
}

