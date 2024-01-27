resource "aws_vpc" "this" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name      = "koo-blog"
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.1.0/24"

  map_public_ip_on_launch = true
  availability_zone       = "ap-northeast-2a"

  tags = {
    Name      = "koo-blog-public-subnet"
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "private" {
  count      = 2
  vpc_id     = aws_vpc.this.id
  cidr_block = var.private_subnets.cidrs[count.index]

  availability_zone = var.private_subnets.azs[count.index]

  tags = {
    Name      = "koo-blog-private-subnet-${count.index}"
    ManagedBy = "Terraform"
  }
}

resource "aws_internet_gateway" "igw" {
  count  = length(var.public_subnets.cidrs) == 0 ? 0 : 1
  vpc_id = aws_vpc.this.id

  tags = {
    Name      = "koo-blog-internetgateway"
    ManagedBy = "Terraform"
  }
}
