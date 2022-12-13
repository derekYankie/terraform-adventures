variable "create" {
  description = "Whether to create an instance"
  type        = bool
  default     = true
}

variable "region" {
  type        = string
  description = "The AWS region."
  nullable    = false
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
  default = ""
}

variable "instance_type" {
  description = "The EC2 instance type to launch"
  type = "string"
  default = "t2.micro"
}
