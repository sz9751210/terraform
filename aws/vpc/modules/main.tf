# 主 VPC 設定
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.main_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

# 建立一個 Internet Gateway，用於 VPC 與外界的連接
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
}

# 為 NAT Gateway 建立彈性 IP
resource "aws_eip" "nat_eip" {
  count  = length(aws_subnet.private_subnets)
  domain = "vpc"

  tags = {
    Name = "${var.prefix}-nat-ip-${count.index}"
  }
}

# 建立 NAT Gateway，用於私有子網的出口流量
resource "aws_nat_gateway" "nat_gateway" {
  count = length(aws_subnet.public_subnets)
  allocation_id = aws_eip.nat_eip[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id

  tags = {
    Name = "${var.prefix}-nat-${count.index}"
  }
}

# 建立公有子網，用於需要對外訪問的資源
resource "aws_subnet" "public_subnets" {
  count                   = 3
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = element(var.public_subnets_cidr, count.index)
  map_public_ip_on_launch = true
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name                     = "${var.prefix}-public-subnet-${count.index}",
    "kubernetes.io/role/elb" = 1
  }
}

# 建立私有子網，用於不需要直接對外訪問的資源
resource "aws_subnet" "private_subnets" {
  count                   = 3
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = element(var.private_subnets_cidr, count.index)
  map_public_ip_on_launch = false
  availability_zone       = element(var.azs, count.index)

  tags = {
    Name                              = "${var.prefix}-private-subnet-${count.index}"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

# 為公有子網配置路由表
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.prefix}-public-route-table"
  }
}

# 將公有子網與路由表關聯
resource "aws_route_table_association" "public_rta" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_table.id
}

# 為私有子網配置路由表
resource "aws_route_table" "private_route_table" {
  count = length(aws_subnet.private_subnets)
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }

  tags = {
    Name = "${var.prefix}-private-route-table-${count.index}"
  }
}

# 將私有子網與路由表關聯
resource "aws_route_table_association" "private_rta" {
  count          = length(aws_subnet.private_subnets)
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}
