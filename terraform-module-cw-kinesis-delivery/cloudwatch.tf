# Cloudwatch metric stream
resource "aws_cloudwatch_metric_stream" "cw_metric_stream" {
  name          = "${var.prefix}-${var.stage}-${var.application}-cw-metric-stream"
  role_arn      = aws_iam_role.kinesis_firehose_role.arn
  firehose_arn  = aws_kinesis_firehose_delivery_stream.destination.arn
  output_format = var.output_format

  dynamic "include_filter" {
    for_each = var.namespace_include_filters

    content {
      namespace = include_filter.value
    }
  }

  dynamic "exclude_filter" {
    for_each = var.namespace_exclude_filters

    content {
      namespace = exclude_filter.value
    }
  }
}
