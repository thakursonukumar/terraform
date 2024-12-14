provider "aws" {
  profile = "personal"
}

variable "custome-ports" {
  type    = list(number)
  default = [22, 4243]  # Specific individual ports
}

variable "allowed_port_range_agents" {
  type    = object({
    from_port = number
    to_port   = number
  })
  default = {
    from_port = 32768
    to_port   = 60999
  }
}

resource "aws_security_group" "jenkins-container-buildAgent-SG" {
  name = "jenkins-container-buildAgent-SG"
  vpc_id = "vpc-0ab0d89d06d87c7a1"
}

resource "aws_security_group_rule" "jenkins-container-buildAgent-SGIngress-list" {
  for_each = toset([for port in var.custome-ports : tostring(port)])
  from_port = each.value
  to_port = each.value
  type = "ingress"
  protocol = "tcp"
  security_group_id = aws_security_group.jenkins-container-buildAgent-SG.id
  cidr_blocks = ["0.0.0.0/0"]
  
}

resource "aws_security_group_rule" "jenkins-container-buildAgent-SGIngress" {
    type = "ingress"
    from_port = var.allowed_port_range_agents.from_port
    to_port = var.allowed_port_range_agents.to_port
    protocol = "tcp"
    security_group_id = aws_security_group.jenkins-container-buildAgent-SG.id
    cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "jenkins-container-buildAgent-SGEgress" {
  type = "egress"
  protocol = "tcp"
  from_port = 443
  to_port = 443
  security_group_id = aws_security_group.jenkins-container-buildAgent-SG.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_key_pair" "my_key" {
  key_name = "my_key"
  public_key = file("D:/ansible-user/id_rsa.pub")
}

resource "aws_instance" "jenkins-build-agent" {
    instance_type = "t3.micro"
    key_name = "my_key"
    # security_groups = [aws_security_group.jenkins-container-buildAgent-SG.id]
    vpc_security_group_ids = [aws_security_group.jenkins-container-buildAgent-SG.id]
    ami = "ami-0f58b397bc5c1f2e8"
    count = 1
    associate_public_ip_address = true
}


output "public-ip-ec2" {
  value = aws_instance.jenkins-build-agent[0].public_ip
}