# security_group.tf
resource "aws_security_group" "jenkins-container-buildAgent-SG" {
  name   = "jenkins-container-buildAgent-SG"
  vpc_id = "vpc-0ab0d89d06d87c7a1"
}

resource "aws_security_group_rule" "jenkins-container-buildAgent-SGIngress-list" {
  for_each = toset([for port in var.custome-ports : tostring(port)])
  from_port = each.value
  to_port   = each.value
  type      = "ingress"
  protocol  = "tcp"
  security_group_id = aws_security_group.jenkins-container-buildAgent-SG.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "jenkins-container-buildAgent-SGIngress" {
  type      = "ingress"
  from_port = var.allowed_port_range_agents.from_port
  to_port   = var.allowed_port_range_agents.to_port
  protocol  = "tcp"
  security_group_id = aws_security_group.jenkins-container-buildAgent-SG.id
  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "jenkins-container-buildAgent-SGEgress" {
  type      = "egress"
  protocol  = "tcp"
  from_port = 0
  to_port   = 65000
  security_group_id = aws_security_group.jenkins-container-buildAgent-SG.id
  cidr_blocks = ["0.0.0.0/0"]
}
