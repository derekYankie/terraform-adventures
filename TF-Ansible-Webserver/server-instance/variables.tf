variable "region" {
  type        = string
  description = "The AWS region."
  defadefault = "us-east-2"
}

variable "aws-profile" {
  description = "IAM User"
  type        = string
  default     = "default"
}

variable "vpc_id" {
  description = "VPC ID"
  default = ""
}

variable "subnet_public_id" {
  description = "VPC public subnet id"
  default = ""
}

variable "security_group_ids" {
  description = "EC2 SSH security group"
  type = "list"
  default = []
}

variable "key_pair_name" {
  description = "EC2 Key pair name"
  default = ""
}

variable "instance_ami" {
  description = "EC2 instance AMI"
  default = "ami-0cf31d971a3ca20d6"
}

variable "instance_type" {
  description = "The EC2 instance type to launch"
  type = "string"
  default = "t2.micro"
}
