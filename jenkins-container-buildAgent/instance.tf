# instance.tf
resource "aws_instance" "jenkins-build-agent" {
  instance_type             = "t3.micro"
  key_name                  = aws_key_pair.my_key.key_name
  vpc_security_group_ids    = [aws_security_group.jenkins-container-buildAgent-SG.id]
  ami                       = "ami-0f58b397bc5c1f2e8"
  count                     = 1
  associate_public_ip_address = true
}
