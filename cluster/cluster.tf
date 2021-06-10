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
resource "aws_security_group" "cluster" {
  name = "server_cluster-sg"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// Launch configuration for server cluster
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