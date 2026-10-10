
#----------------------------
# AZ-1a
#----------------------------

resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_a_cidr
  availability_zone       = var.AZ-1a
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-az1a"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_a_cidr
  availability_zone = var.AZ-1a

  tags = {
    Name = "${var.project_name}-private-az1a"
  }
}


#----------------------------
# AZ-1b
#----------------------------
resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_b_cidr
  availability_zone       = var.AZ-1b
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-az1b"
  }
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_b_cidr
  availability_zone = var.AZ-1b

  tags = {
    Name = "${var.project_name}-private-az1b"
  }
}