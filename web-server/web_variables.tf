# Variables for web-server configuration file
variable "region" {
  type        = string
  description = "The AWS region"
  default     = "us-west-2"
}

variable "instance_type" {
  type        = string
  description = "The instance type to launch"
  default     = "t2.micro"
}

variable "server_port" {
  type        = number
  description = "The port the server will use for HTTP requests"
  default     = 8080
}

# Outputs
output "public_ip" {
  value       = aws_instance.web_server.public_ip
  description = "The public IP address of the web server."
}
