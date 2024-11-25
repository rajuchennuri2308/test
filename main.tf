# VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

# Subnets
resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet1_cidr
  availability_zone       = "${var.region}a"
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet1_name
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet2_cidr
  availability_zone       = "${var.region}b"
  map_public_ip_on_launch = true
  tags = {
    Name = var.subnet2_name
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.igw_name
  }
}

# Route Table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.route_cidr
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.route_table_name
  }
}

# Route Table Associations
resource "aws_route_table_association" "subnet1_association" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "subnet2_association" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.main.id
}

# Security Group
resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.sg_name
  }
}

# Launch Template
resource "aws_launch_template" "web_lt" {
  name          = var.launch_template_name
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = base64encode(var.user_data)
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.web_sg.id]
  }
  tags = {
    Name = var.launch_template_name
  }
}

# Auto Scaling Group
resource "aws_autoscaling_group" "web_asg" {
  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }
  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  vpc_zone_identifier = [
    aws_subnet.subnet1.id,
    aws_subnet.subnet2.id
  ]
  target_group_arns = [aws_lb_target_group.web_tg.arn]
}

# Load Balancer
resource "aws_lb" "web_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  enable_deletion_protection = false
}

# Target Group
resource "aws_lb_target_group" "web_tg" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
  health_check {
    path                = var.health_check_path
    interval            = var.health_check_interval
    timeout             = var.health_check_timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }
}

# Load Balancer Listener
resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}
