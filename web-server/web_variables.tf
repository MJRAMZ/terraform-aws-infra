# Variables for base configuration file
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