module "vpc" {
  source          = "../modules/vpc"
  vpc_name        = local.vpc_name
  vpc_cidr        = local.vpc_cidr
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets
}
