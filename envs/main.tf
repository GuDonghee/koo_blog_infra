terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

locals {

  # VPC
  vpc_cidr       = "10.0.0.0/16"
  vpc_name       = "koo-blog"
  public_subnets = {
    cidrs = [
      "10.0.1.0/24",
      "10.0.4.0/24"
    ]
    azs = [
      "ap-northeast-2c",
      "ap-northeast-2a"
    ]
  }
  private_subnets = {
    cidrs = [
      "10.0.2.0/24",
      "10.0.3.0/24"
    ]
    azs = [
      "ap-northeast-2c",
      "ap-northeast-2a"
    ]
  }

  # RDS
  subnet_group_name = "koo-blog-db-subnet-group"
  allocated_storage = 20
  engine_version    = "8.0.35"
  instance_class    = "db.t3.micro"
}
