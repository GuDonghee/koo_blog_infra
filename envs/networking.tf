module "vpc" {
  source          = "../modules/vpc"
  vpc_name        = local.vpc_name
  vpc_cidr        = local.vpc_cidr
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets
}

module "ec2" {
  source        = "../modules/ec2"
  aws_ami       = "amzn2-ami-hvm-2.0.*-x86_64-gp2"
  vpc_name      = local.vpc_name
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.public_subnet_ids[0]
  instance_type = "t2.micro"
}
