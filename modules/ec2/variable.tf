variable "ami" {
  description = "The AMI ID to use for the EC2 instances"
  type        = string
}
variable "instance_type" {
  description = "type of the instace"
  type        = string
  
}
variable "subnet_ids" {
    description = "Id of the subnet"
    type = string
  
}

variable "key_pair_name" {
  description = "The name of the key pair to use for the EC2 instances"
  type        = string
}



variable "security_group_ids" {
   
}



variable "instance_name" {
  description = "Name of the instance"
  type        = string
  
}



# variable "eip_ids" {
#   description = "Id of the subnet"
#     type = string
  
# }