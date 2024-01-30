resource "aws_vpc" "koo-blog" {
  cidr_block = var.vpc_cidr

  tags = {
    Name      = var.vpc_name
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "public" {
  count      = length(var.public_subnets.cidrs)
  vpc_id     = aws_vpc.koo-blog.id
  cidr_block = var.public_subnets.cidrs[count.index]

  map_public_ip_on_launch = true
  availability_zone       = var.public_subnets.azs[count.index]

  tags = {
    Name      = "${var.vpc_name}-public-subnet-${count.index}"
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "private" {
  count      = length(var.private_subnets.cidrs)
  vpc_id     = aws_vpc.koo-blog.id
  cidr_block = var.private_subnets.cidrs[count.index]

  availability_zone = var.private_subnets.azs[count.index]

  tags = {
    Name      = "${var.vpc_name}-private-subnet-${count.index}"
    ManagedBy = "Terraform"
  }
}

resource "aws_internet_gateway" "igw" {
  count  = length(var.public_subnets.cidrs) == 0 ? 0 : 1
  vpc_id = aws_vpc.koo-blog.id

  tags = {
    Name      = "${var.vpc_name}-igw"
    ManagedBy = "Terraform"
  }
}
