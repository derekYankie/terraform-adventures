variable "prefix" {
  type        = string
  description = "Kinesis delivery stream prefix."
  nullable    = false
  default     = "demo"
}

variable "region" {
  type        = string
  description = "The AWS region."
  nullable    = false
}

variable "stage" {
  type        = string
  description = "ID element. Usually used to indicate: role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release.'"
  nullable    = false
}

variable "application" {
  type        = string
  description = "Application name/type - part of naming convention to apply."
  nullable    = false
}

variable "aws_account_id" {
  description = "The AWS account ID where the OIDC provider lives, (leave empty to use the account for the AWS provider)."
  type        = string
  nullable    = false
}

variable "destinantion_firehose_endpoint" {
  type        = string
  description = "Destination HTTP Endpoint URL."
  nullable    = false
}

variable "http_endpoint_buffering_interval" {
  description = "Kinesis Firehose buffer interval (in seconds)."
  type        = number
  default     = 60
}

variable "http_endpoint_buffering_size" {
  description = "Kinesis Firehose buffer (size in MB)."
  type        = number
  default     = 4
}

variable "output_format" {
  description = "CloudWatch metric stream output format."
  type        = string
  nullable    = false
}

variable "http_access_key" {
  description = "This the destination API Key."
  type        = string
  nullable    = true
}

variable "http_endpoint_retry_duration" {
  description = "Kinesis Firehose stream retry (in seconds)."
  type        = number
  default     = 60
}

variable "namespace_include_filters" {
  description = "A list of CloudWatch Metric namespaces to stream metrics. Optional."
  type        = list(string)
  default     = []
}

variable "namespace_exclude_filters" {
  description = "A list of CloudWatch Metric namespaces to stream metrics. Optional."
  type        = list(string)
  default     = []
}

variable "s3_buffer_interval" {
  description = "S3 buffer interval (in seconds)."
  type        = number
  default     = 300
}

variable "s3_buffer_size" {
  description = "S3 buffer (size in MB)."
  type        = number
  default     = 5
}

variable "log_group_names" {
  description = "List of log groups to subscribe to with the log filter"
  type        = list(string)
  default     = []
}

variable "kinesis_lg_retention_in_days" {
  description = "Kinesis log group retention (time in days)."
  type        = number
  default     = 7
}
