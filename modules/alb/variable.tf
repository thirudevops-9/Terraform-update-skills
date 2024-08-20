variable "alb_name" {
  
}

variable "security_group_ids" {
  
}

variable "alb_subnets_ids" {
    
  
}
variable "tg_name" {
  
}

variable "alb_vpc_id" {
  
}

variable "ec2_instance_id" {
  description = "EC2 instance ID to attach to the target group"
  type        = string
}


variable "ssl_policy" {
  type = string
  default = "ELBSecurityPolicy-2016-08"
}

variable "certificate_arn" {
  type = string
}
