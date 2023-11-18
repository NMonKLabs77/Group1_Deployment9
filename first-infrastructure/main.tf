# configure aws provider
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = "us-east-1"
}


# create instance
resource "aws_instance" "jenkins_man" {
  ami = var.micro_ami
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = [var.defaultsg]
  key_name = "d9"

  user_data = "${file("deployJenkins.sh")}"

  tags = {
    "Name" : "d9_Jenkins_instance"
  }

}

# create instance
resource "aws_instance" "EKS" {
  ami = var.medium_ami
  instance_type = "t2.medium"
  associate_public_ip_address = true
  vpc_security_group_ids = [var.defaultsg]
  key_name = "d9"
  user_data = "${file("deployEKS.sh")}"

  tags = {
    "Name" : "d9_EKS"
  }

}

# create instance
resource "aws_instance" "docker" {
  ami = var.medium_ami
  instance_type = "t2.medium"
  associate_public_ip_address = true
  vpc_security_group_ids = [var.defaultsg]
  key_name = "d9"
  user_data = "${file("deploydocker.sh")}"

  tags = {
    "Name" : "d9_Docker"
  }

}


output "instance_ip" {
  value = aws_instance.jenkins_man.public_ip

}

output "instance_ip2" {
  value = aws_instance.EKS.public_ip
}

output "instance_ip3" {
  value = aws_instance.docker.public_ip
}