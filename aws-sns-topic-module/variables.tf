variable "prefix" {
  type        = string
  description = "Kinesis delivery stream prefix."
  nullable    = false
  default     = "dt"
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