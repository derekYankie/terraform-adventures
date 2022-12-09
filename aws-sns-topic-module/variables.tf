variable "prefix" {
  type        = string
  description = "SNS Topic prefix"
  nullable    = false
  default     = "demo"
}

variable "region" {
  type        = string
  description = "The AWS region"
  nullable    = false
}

variable "aws-profile" {
  description = "IAM User"
  type        = string
  default     = "default"
}
