#---------------------
# AZ-1a
#---------------------
resource "aws_instance" "web_a" {
  ami                         = var.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_a.id
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true

  tags = {
    Name = "${var.project_name}-bastion-az1a"
  }
}

resource "aws_instance" "backend_a" {
  ami                         = var.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.private_a.id
  vpc_security_group_ids      = [aws_security_group.backend.id]
  associate_public_ip_address = false
  tags = {
    Name = "${var.project_name}-backend-az1a"
  }
}

#---------------------
#AZ-1b
#---------------------
resource "aws_instance" "web_b" {
  ami                         = var.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_b.id
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true
  tags = {
    Name = "${var.project_name}-web-az1b"
  }
}

resource "aws_instance" "backend_b" {
  ami                         = var.ami_id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.private_b.id
  vpc_security_group_ids      = [aws_security_group.backend.id]
  associate_public_ip_address = false
  tags = {
    Name = "${var.project_name}-backend-az1b"
  }
}


