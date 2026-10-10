#-----------
# elastic-ip
#-----------
resource "aws_eip" "elastic_ip" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-elastic-eip"
  }
}

#-------------
# nat-gateway
#-------------
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public_a.id

  tags = {
    Name = "${var.project_name}-nat-gateway"
  }
  depends_on = [aws_internet_gateway.gateway]

}