# key_pair.tf
resource "aws_key_pair" "my_key" {
  key_name   = "jenkins_key"
  public_key = file("D:/personal-ssh-keys/jenkins.pub")
}
