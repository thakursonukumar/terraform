provider "aws" {
    region = "ap-south-1"
    profile = "personal"
}

resource "aws_key_pair" "windows-key" {
    key_name = "windows_key"
    public_key = file("C:/Users/sonukumar.thakur/.ssh/id_rsa.pub")
}