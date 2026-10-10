
#--------------Public ALB Security Group-----------------
resource "aws_security_group" "public_alb" {
  name = "${var.name}-public-alb-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#--------------Public ALB-----------------
resource "aws_lb" "public" {
  name               = "${var.name}-public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_alb.id]
  subnets            = var.public_subnet_ids
}

#--------------Public Target Group-----------------
resource "aws_lb_target_group" "public" {
  name     = "${var.name}-public-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

#--------------Public Target Group Attachment-----------------
resource "aws_lb_target_group_attachment" "public" {
  count            = 2
  target_group_arn = aws_lb_target_group.public.arn
  target_id        = var.public_instance_ids[count.index]
  port             = 80
}

#--------------Public ALB Listener-----------------
resource "aws_lb_listener" "public" {
  load_balancer_arn = aws_lb.public.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public.arn
  }
}


#############################################################
############## Internal ALB Resources #####################
#############################################################


#--------------Internal ALB Security Group-----------------
resource "aws_security_group" "internal_alb" {
  name = "${var.name}-internal-alb-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]   # only from inside the VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#--------------Internal ALB-----------------
resource "aws_lb" "internal" {
  name               = "${var.name}-internal-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.internal_alb.id]
  subnets            = var.private_subnet_ids
}


#--------------Internal Target Group-----------------
resource "aws_lb_target_group" "internal" {
  name     = "${var.name}-internal-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}


#--------------Internal Target Group Attachment-----------------
resource "aws_lb_target_group_attachment" "internal" {
  count            = 2
  target_group_arn = aws_lb_target_group.internal.arn
  target_id        = var.private_instance_ids[count.index]
  port             = 80
}


#-------------Internal ALB Listener-----------------
resource "aws_lb_listener" "internal" {
  load_balancer_arn = aws_lb.internal.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal.arn
  }
}