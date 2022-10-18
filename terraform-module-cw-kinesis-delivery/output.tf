output "kinesis_delivery_stream" {
  value       = aws_kinesis_firehose_delivery_stream.destination.name
  description = "Kinesis Delivery stream"
}

output "cloudwatch_metric_stream" {
  value       = aws_cloudwatch_metric_stream.cw_metric_stream.name
  description = "CloudWatch metric stream"
}

output "metric_format" {
  value       = aws_cloudwatch_metric_stream.cw_metric_stream.output_format
  description = "Metric format"
}
