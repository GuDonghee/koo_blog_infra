resource "aws_db_subnet_group" "subnet_group" {
  name       = var.subnet_group_name
  subnet_ids = var.private_subnet_ids

  tags = {
    Name      = var.subnet_group_name
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group" "rds" {

  description = "Access for the EC2 Application Server"
  name        = "${var.vpc_name}-rds-security"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 3306
    protocol        = "tcp"
    to_port         = 3306
    security_groups = [var.application_sg_id]
  }

  tags = {
    Name      = "${var.vpc_name}-rds-security"
    ManagedBy = "Terraform"
  }
}

resource "aws_db_instance" "rds" {
  identifier              = var.rds_instance.identifier
  db_name                 = var.rds_instance.db_name
  allocated_storage       = var.rds_instance.allocated_storage
  storage_type            = var.rds_instance.storage_type
  engine                  = var.rds_instance.engine
  engine_version          = var.rds_instance.engine_version
  instance_class          = var.rds_instance.instance_class
  db_subnet_group_name    = aws_db_subnet_group.subnet_group.name
  username                = var.rds_instance.username
  password                = var.rds_instance.password
  backup_retention_period = var.rds_instance.backup_retention_period
  multi_az                = var.rds_instance.multi_az
  skip_final_snapshot     = var.rds_instance.skip_final_snapshot

  tags = {
    Name      = var.rds_instance.identifier
    ManagedBy = "Terraform"
  }
}
