module "koo-blog-rds" {
  source = "../modules/rds"

  subnet_group_name  = local.subnet_group_name
  vpc_id             = module.vpc.vpc_id
  vpc_name           = local.vpc_name
  private_subnet_ids = module.vpc.private_subnet_ids
  application_sg_id  = module.vpc.application_sg_id

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
