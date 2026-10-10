
## Create dev VPC 
resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "dev-vpc"
  }
}

################
#dev vpc subnets
################

#public subnet
resource "aws_subnet" "dev-pub-sub" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "dev-public-subnet"
  }
}

#private subnet
resource "aws_subnet" "dev-priv-sub" {
  vpc_id     = aws_vpc.dev-vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "dev-private-subnet"
  }
}



