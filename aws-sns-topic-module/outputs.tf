output "aws_sns_topic_name" {
  description = "The name of the bucket."
  value       = aws_s3_bucket.aws_sns_topic.id
}
