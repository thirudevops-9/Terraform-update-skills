# Terraform providers installation

provider "aws" {
  region = "us-east-1"
}

# tf state file store into s3 and lock the state file
terraform {
  backend "s3" {
    bucket         = "thiru-demo-1"
    key            = "terraform.tfstate" # Adjust the path as needed
    region         = "us-east-1"         # e.g., us-west-2
    dynamodb_table = "thiru_locks"
    encrypt        = true
  }
}


#Pem key module 
module "pemkey" {
  source   = "../modules/pemkey"
  key_name = "thiru.pem"

}


# Ec2 module 
module "ec2" {
  source             = "../modules/ec2"
  ami                = "ami-0a0e5d9c7acc336f1"
  instance_type      = "t2.micro"
  subnet_ids         = "subnet-0b96ada2e6552ae4a"
  security_group_ids = ["sg-0a4c96dc4582fa4e6"]
  key_pair_name      = module.pemkey.key_pair_name
  instance_name      = "thiru-instance"
}


# eip_ids            = "98.80.109.198"



# s3 module 

module "s3_bucket" {
  source         = "../modules/s3_bucket"
  s3_bucket_name = "thiru-demo-1"
}

# dynamo_db 
module "dynamo_db" {
  source        = "../modules/dynamo_db"
  dynamodb_name = "thiru_locks"

}

# alb module 
module "alb" {
  source             = "../modules/alb"
  alb_name           = "node-alb"
  security_group_ids = ["sg-0a4c96dc4582fa4e6"]
  alb_subnets_ids    = ["subnet-0b96ada2e6552ae4a", "subnet-0a8bd16e3c9fb13f6"]
  tg_name            = "node-alb-tg"
  alb_vpc_id         = "vpc-0eb93dba1ff38dd37"
  ec2_instance_id = module.ec2.ec2_instance_id
  ssl_policy         = "ELBSecurityPolicy-2016-08"
  certificate_arn    = module.ssl_certificate.certificate_arn
} 



#Route 53 
module "route53" {
  source         = "../modules/route53"
  domain_name    = "thiruamego.shop"
  subdomain_name = "demo.thiruamego.shop"
  alb_dns_name   = module.alb.alb_dns_name
  record_name    = "demo"                     # Replace with the desired record name
  cname_target   = module.alb.alb_dns_name    # Typically the ALB DNS name or another target
  alb_zone_id    = module.alb.alb_zone_id     # You need to output alb_zone_id from the alb module
  
}

module "ssl_certificate" {
  source = "../modules/ssl_certificate"
  
  domain_name               = "demo.thiruamego.shop"
  subject_alternative_names = ["demo.thiruamego.shop"]
  route53_zone_id           = "Z02681251YVZRZVDLVXIC"
  region                    = "us-east-1"
  
}



