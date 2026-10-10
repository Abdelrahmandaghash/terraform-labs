
#--------------VPC-----------------
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags= {
     Name = "${var.name}-vpc" 
     }
}


#--------------Public Subnets-----------------
resource "aws_subnet" "public-subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = { 
    Name = "${var.name}-public-${count.index + 1}" 
    }
}

#--------------Private Subnets-----------------
resource "aws_subnet" "private-subnet" {
  count             = 2
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
     Name = "${var.name}-private-${count.index + 1}" 
     }
}

#--------------Internet Gateway-----------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags  = {
     Name = "${var.name}-igw" 
     }
}

#--------------Elastic IP-----------------
resource "aws_eip" "eip" {
  domain = "vpc"

  tags = {
     Name = "${var.name}-eip" 
     }
}

#--------------NAT Gateway-----------------
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public-subnet[0].id

  tags = {
     Name = "${var.name}-nat" 
     }

  depends_on    = [aws_internet_gateway.igw]
}


#--------------Route Tables Public-----------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = { 
    Name = "${var.name}-public-rt" 
    }
}


#--------------Route Tables Private-----------------
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
     Name = "${var.name}-private-rt" 
    }
}


#--------------Public Route Table Associations-----------------
resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.public.id
}

#--------------Private Route Table Associations-----------------
resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.private.id
}