#-----------
# elastic-ip
#-----------
resource "aws_eip" "elastic_ip" {
  domain = "vpc"

  tags = {
    Name = "${var.environment}-elastic-eip"
  }
}

#-------------
# nat-gateway
#-------------
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.environment}-nat-gateway"
  }
  depends_on = [aws_internet_gateway.gateway]

}