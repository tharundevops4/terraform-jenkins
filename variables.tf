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