# Kinesis Delivery stream
resource "aws_kinesis_firehose_delivery_stream" "destination" {
  name        = "${var.prefix}-${var.stage}-${var.application}-kinesis-delivery-stream"
  destination = "http_endpoint"

  s3_configuration {
    bucket_arn      = aws_s3_bucket.kinesis_failed_streams_bucket.arn
    buffer_interval = var.s3_buffer_interval
    buffer_size     = var.s3_buffer_size
    role_arn        = aws_iam_role.kinesis_firehose_role.arn

    cloudwatch_logging_options {
      enabled = false
    }
  }

  server_side_encryption {
    enabled = true
  }
  # Destination Endpoint
  http_endpoint_configuration {
    name               = "${var.prefix}-${var.stage}-${var.application}-kinesis-delivery-stream"
    access_key         = sensitive(var.http_access_key)
    buffering_interval = var.http_endpoint_buffering_interval
    buffering_size     = var.http_endpoint_buffering_size
    retry_duration     = var.http_endpoint_retry_duration
    role_arn           = aws_iam_role.kinesis_firehose_role.arn
    s3_backup_mode     = "FailedDataOnly"
    url                = var.destinantion_firehose_endpoint

    processing_configuration {
      enabled = false
    }

    request_configuration {
      content_encoding = "GZIP"

      common_attributes {
        name  = "Name"
        value = "${var.prefix}-${var.stage}-${var.application}-kinesis-delivery-stream"
      }
      common_attributes {
        name  = "env"
        value = var.stage
      }
    }
  }
  tags = {
    Name = "${var.prefix}-${var.stage}-${var.application}-kinesis-delivery-stream"
  }
}
