# outputs.tf
output "public-ip-ec2" {
  value = aws_instance.jenkins-build-agent[0].public_ip
}
