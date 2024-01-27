resource "aws_db_instance" "rds" {
  identifier              = var.rds_instance.identifier
  db_name                 = var.rds_instance.db_name
  allocated_storage       = var.rds_instance.allocated_storage
  storage_type            = var.rds_instance.storage_type
  engine                  = var.rds_instance.engine
  engine_version          = var.rds_instance.engine_version
  instance_class          = var.rds_instance.instance_class
  db_subnet_group_name    = var.subnet_group_name
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