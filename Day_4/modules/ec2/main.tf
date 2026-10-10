


#-----------------Web Security Group-----------------
resource "aws_security_group" "web" {
  name = "${var.name}-web-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#--------------Public EC2 Instances-----------------
resource "aws_instance" "public" {
  count                  = 2
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.public_subnet_ids[count.index]
  vpc_security_group_ids = [aws_security_group.web.id]

  tags = {
     Name = "${var.name}-public-${count.index + 1}" 
     }
}

#--------------Private EC2 Instances-----------------
resource "aws_instance" "private" {
  count                  = 2
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_ids[count.index]
  vpc_security_group_ids = [aws_security_group.web.id]

  tags = {
     Name = "${var.name}-private-${count.index + 1}" 
     }
}