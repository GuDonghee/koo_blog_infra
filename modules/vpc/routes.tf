resource "aws_route_table" "public" {
  count  = length(var.public_subnets.cidrs) == 0 ? 0 : 1
  vpc_id = aws_vpc.koo-blog.id

  tags = {
    Name      = "${var.vpc_name}-public-rt"
    ManagedBy = "Terraform"
  }
}

resource "aws_route_table" "private" {
  count  = length(var.private_subnets.cidrs) == 0 ? 0 : 1
  vpc_id = aws_vpc.koo-blog.id

  tags = {
    Name      = "${var.vpc_name}-private-rt"
    ManagedBy = "Terraform"
  }
}

resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets.cidrs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[0].id
}

resource "aws_route_table_association" "private" {
  count          = length(var.private_subnets.cidrs)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[0].id
}

resource "aws_route" "public" {
  count                  = length(var.public_subnets.cidrs)
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw[0].id
}
