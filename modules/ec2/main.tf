
# create ec2 instance and upload file and run the docker container 

resource "aws_instance" "ec2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_ids
  key_name               = var.key_pair_name
  vpc_security_group_ids = var.security_group_ids



  tags = {
    Name = var.instance_name

  }
  provisioner "local-exec" {
     interpreter = ["bash", "-c"]
     command = <<EOT
       echo "Sleeping for 30 seconds to ensure the instance is fully ready"
       sleep 30
       scp -o StrictHostKeyChecking=no -i ${var.key_pair_name} ../server/app.zip ubuntu@${aws_instance.ec2.public_ip}:/home/ubuntu
     EOT
  }

   provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y docker.io",
      "sudo service docker start",
      "sudo apt install -y unzip",
      
      "unzip app.zip",
      "sudo docker build -t ec2js .",
      "sudo docker run -d -p 3000:3000 ec2js"
    ]
 
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.key_pair_name}")
      host        = self.public_ip
    }
  }

}

# # # call the Exciting EIP 
# data "aws_eip" "existing_eip" {
#   public_ip = var.eip_ids
# }

# # # EIP attach the Ec2 
# resource "aws_eip_association" "eip_attach" {
#   instance_id   = aws_instance.ec2.id
#   allocation_id = data.aws_eip.existing_eip.id
# }









