data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = [var.aws_ami]
  }

  owners = ["amazon"]
}

data "aws_key_pair" "bastion_session" {
  key_name           = "koo-blog-key"
  include_public_key = true
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = data.aws_key_pair.bastion_session.key_name

  vpc_security_group_ids = [
    aws_security_group.bastion.id
  ]

  tags = {
    Name      = "${var.vpc_name}-bastion"
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group" "bastion" {

  description = "Access for the EC2 Bastion Server"
  name        = "${var.vpc_name}-bastion-security"
  vpc_id      = var.vpc_id

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
    Name      = "${var.vpc_name}-bastion-private-security"
    ManagedBy = "Terraform"
  }
}
