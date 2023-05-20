variable "aws-region" {
  description = "AWS Region"
  type        = string
  default     = "us-west-2"
}

variable "aws-profile" { 
  description = "Default IAM User"
  type        = string
  default     = "default"
}

variable "eks_vpc_name" {
  description = "VPC name for EKS S3"
  type        = string
  default     = "eks-ng-vpc"
}
