resource "aws_lb" "alb" {
  name               = "${var.vpc_name}-alb"
  load_balancer_type = "application"
  subnets            = [
    aws_subnet.public[0].id,
    aws_subnet.public[1].id
  ]

  security_groups = [aws_security_group.alb.id]

  tags = {
    Name      = "${var.vpc_name}-alb"
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group" "alb" {

  description = "Access for the EC2 Application Server"
  name        = "${var.vpc_name}-alb-security"
  vpc_id      = aws_vpc.koo-blog.id

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