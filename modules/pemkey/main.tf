
# refer-link: https://www.youtube.com/watch?v=eBW0MWOBwe0
#create pem key format
resource "tls_private_key" "rsa_4096" {
  algorithm = "RSA"
  rsa_bits  = 4096

}


#create key pair for the aws 
resource "aws_key_pair" "key_name" {
  key_name   = var.key_name
  public_key = tls_private_key.rsa_4096.public_key_openssh
}

# save the priavte key in the local system
resource "local_file" "private_key" {
  content  = tls_private_key.rsa_4096.private_key_pem
  filename = var.key_name
}