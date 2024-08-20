
# output "ec2_public_ip" {
#   value       = data.aws_eip.existing_eip.public_ip
#   description = "The Elastic IP address associated with the EC2 instance."
# }


output "ec2_instance_id" {
  value = aws_instance.ec2.id
}
