provider "aws" {
  region="ap-south-1"
  profile = "personal"
}

resource "aws_key_pair" "my_key_pair" {
  key_name = "my_key"
  public_key = file("D:/ansible-user/id_rsa.pub")
}

resource "aws_instance" "my-ec2" {
  ami = "ami-0f58b397bc5c1f2e8"
  instance_type = var.instance_type
  associate_public_ip_address = var.public_ip
  count = var.instance_count
  key_name = "my_key"
  vpc_security_group_ids = ["sg-0f28a4ab81d16967a"]
  tags = {
    Name = "Terraform-EC2"
  }
}

variable "instance_type" {
  description = "instance type"
  type = string
  default = "t2.micro"
}

variable "public_ip" {
  description = "public ip enable/disable"
  type = bool
  default = true
}

variable "instance_count" {
  description = "number of ec2 to be spin"
  type = number
  default = 1
}

output "instance_plubic" {
  value = aws_instance.my-ec2[0].public_ip
  
}