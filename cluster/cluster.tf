# Base configuration file
# Base settings
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.27"
    }
  }
  required_version = ">= 0.14.9"
}

# Provider - AWS
provider "aws" {
  profile = "default"
  region  = var.region
}

# Data source for Ubuntu AMI
data "aws_ami" "ubuntu_latest" {
  owners      = ["099720109477"]
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Security group flor launch config
resource "aws_security_group" "cluster" {
  name = "server_cluster-sg"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch configuration for server cluster
resource "aws_launch_configuration" "cluster" {
  image_id = data.aws_ami.ubuntu_latest.id
  instance_type = var.instance_type
  security_groups = [aws_security_group.cluster.id]
  user_data = file("files/hello.sh")
  key_name = var.key_name

   # Required when using a launch configuration with an auto scaling group.
  # https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
  lifecycle {
    create_before_destroy = true
  }
}

# Auto-scaling group
resource "aws_autoscaling_group" "cluster" {
  launch_configuration = aws_launch_configuration.cluster.name
  vpc_zone_identifier = data.aws_subnet_ids.default.ids

  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"

  min_size = 2
  max_size = 10

  tag {
    key = "Name"
    value = "terraform-asg-cluster"
    propagate_at_launch = true
  }
}

# Data source for default vpc
data "aws_vpc" "default" {
  default = true
}

# Data source for default subnet ids
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

# Load balancer
resource "aws_lb" "cluster" {
  name = "terraform-asg-cluster"
  load_balancer_type = "application"
  subnets = data.aws_subnet_ids.default.ids
}

# Load balancer listener
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.cluster.arn
  port = 80
  protocol = "HTTP"

  # By default, return 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code = 404
    }
  }
}

# Load balancer target group
resource "aws_lb_target_group" "asg" {
  name = var.alb_name

  port = var.server_port
  protocol = "HTTP"
  vpc_id = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

# Load balancer listener rule
resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}

# Load balancer security group for LB
resource "aws_security_group" "alb" {
  name = var.alb_security_group_name

  # Allow inbound HTTP requests
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound requests
  egress {
    from_port = 0
    to_port = 0
    protocol ="-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}