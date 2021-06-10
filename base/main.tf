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
  owners = ["099720109477"]

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

// EC2 virtual server instance
resource "aws_instance" "single_server" {
  ami           = data.aws_ami.ubuntu_latest.id
  instance_type = var.instance_type

  tags = {
    Name = "base"
  }
}
