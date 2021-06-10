# Variables for web-server cluster configuration file
variable "region" {
  type        = string
  description = "The AWS region"
  default     = "us-west-2"
}

variable "key_name" {
  type        = string
  description = "The AWS key pair to use for resources"
  default     = "web_server"
}

variable "alb_name" {
  type        = string
  description = "The name of the ALB"
  default     = "terraform-asg-cluster"
}

variable "instance_security_group_name" {
  type        = string
  description = "The name of the securoty group for EC2 instances"
  default     = "terraform-cluster-instance-sg"
}

variable "alb_security_group_name" {
  type        = string
  description = "The name of the securoty group for the ALB"
  default     = "terraform-cluster-alb-sg"
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
