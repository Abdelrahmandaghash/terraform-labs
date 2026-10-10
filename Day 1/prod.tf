


# Create prod VPC 
resource "aws_vpc" "prod-vpc" {
  cidr_block = "172.18.0.0/16"
  tags = {
    Name = "prod-vpc"
  }
}

################
#prod vpc subnets
################

#pub subnet
resource "aws_subnet" "prod-pub-sub" {
  vpc_id     = aws_vpc.prod-vpc.id
  cidr_block = "172.18.1.0/24"
  tags = {
    Name = "prod-public-subnet"
  }
}

#private subnet
resource "aws_subnet" "prod-priv-sub" {
  vpc_id     = aws_vpc.prod-vpc.id
  cidr_block = "172.18.2.0/24"
  tags = {
    Name = "prod-private-subnet"
  }
}