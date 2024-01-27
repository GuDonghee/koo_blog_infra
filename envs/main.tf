locals {

  # VPC
  vpc_cidr       = "10.0.0.0/16"
  public_subnets = {
    cidrs = ["10.0.1.0/24"]
    azs   = ["ap-northeast-2a"]
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
}
