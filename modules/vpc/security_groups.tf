resource "aws_security_group" "application" {

  description = "Access for the EC2 Application Server"
  name        = "${var.vpc_name}-application-security"
  vpc_id      = aws_vpc.this.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "${var.vpc_name}-application-security"
    ManagedBy = "Terraform"
  }
}
