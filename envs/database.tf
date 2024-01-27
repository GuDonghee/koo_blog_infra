module "koo-blog-rds" {
  source = "../modules/rds"

  subnet_group_name = local.subnet_group_name

  rds_instance = {
    identifier              = "koo-blog-rds"
    db_name                 = var.db_name
    username                = var.db_username
    password                = var.db_password
    allocated_storage       = local.allocated_storage
    storage_type            = "gp2"
    engine                  = "mysql"
    engine_version          = local.engine_version
    instance_class          = local.instance_class
    backup_retention_period = 0
    multi_az                = false
    skip_final_snapshot     = true
  }
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = local.subnet_group_name
  subnet_ids = module.vpc.private_subnet_ids

  tags = {
    Name      = local.subnet_group_name
    ManagedBy = "Terraform"
  }
}

resource "aws_security_group" "rds" {

  description = "Access for the EC2 Application Server"
  name        = "${local.vpc_name}-rds-security"
  vpc_id      = module.vpc.vpc_id

  egress
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 3306
    protocol        = "tcp"
    to_port         = 3306
    security_groups = [module.vpc.application_sg_id]
  }

  tags = {
    Name      = "${local.vpc_name}-rds-security"
    ManagedBy = "Terraform"
  }
}
