variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  default = "ami-0c614dee691cbbf37"
}

variable "ebs_size" {
  default = 8
}

variable "key_name" {
  default = "mainkey"
}

variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}