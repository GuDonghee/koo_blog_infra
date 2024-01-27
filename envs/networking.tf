module "vpc" {
  source          = "../modules/vpc"
  vpc_name        = "koo-blog"
  vpc_cidr        = local.vpc_cidr
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets
}
