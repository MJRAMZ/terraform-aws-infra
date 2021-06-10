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

// Security group
resource "aws_security_group" "web_server" {
  name = "web_server-sg"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// Instance
resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.ubuntu_latest.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.web_server.id]
  user_data              = file("files/hello.sh")
  key_name               = var.key_name

  tags = {
    Name = "web_server"
  }
}