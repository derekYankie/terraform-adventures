# Kinesis Firehose S3 Policy
data "aws_iam_policy_document" "kinesis_firehose_s3_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:AbortMultipartUpload",
      "s3:GetBucketLocation",
      "s3:GetObject",
      "s3:ListBucket",
      "s3:ListBucketMultipartUploads",
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.kinesis_failed_streams_bucket.arn}",
      "${aws_s3_bucket.kinesis_failed_streams_bucket.arn}/*"
    ]
  }
}

# Kinesis Firehose Policy
data "aws_iam_policy_document" "kinesis_firehose_policy" {
  statement {
    actions = [
      "kinesis:DescribeStream",
      "kinesis:GetShardIterator",
      "kinesis:GetRecords",
      "kinesis:ListShards"
    ]

    resources = [
      aws_kinesis_firehose_delivery_stream.destination.arn
    ]
  }
}

# Attach Kinesis Firehose S3 Policy
resource "aws_iam_role" "kinesis_firehose_s3_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "kinesis.amazonaws.com"
        }
      },
    ]
  })

  inline_policy {
    name   = "${var.prefix}-${var.stage}-${var.application}-kinesis-s3-iam-policy"
    policy = data.aws_iam_policy_document.kinesis_firehose_s3_policy.json
  }

  name        = "${var.prefix}-${var.stage}-${var.application}-kinesis-s3-iam-role"
  description = "IAM Role for Kinesis Firehose for S3"

  tags = {
    Name = "${var.prefix}-${var.stage}-${var.application}-kinesis-s3-iam-role"
  }
}

# Attach Kinesis Firehose Policy
resource "aws_iam_role" "kinesis_firehose_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "kinesis.amazonaws.com"
        }
      },
    ]
  })

  name        = "${var.prefix}-${var.stage}-${var.application}-kinesis-iam-role"
  description = "IAM Role for Kinesis Firehose"

  tags = {
    Name = "${var.prefix}-${var.stage}-${var.application}-kinesis-iam-role"
  }
}

resource "aws_iam_role_policy" "kinesis_inline" {
  name   = "${var.prefix}-${var.stage}-${var.application}-kinesis-iam-policy"
  role   = aws_iam_role.kinesis_firehose_role.id
  policy = data.aws_iam_policy_document.kinesis_firehose_policy.json
}

# IAM Role for for CloudWatch metric stream to Kinesis Firehose
data "aws_iam_policy_document" "cw_firehose_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["streams.metrics.cloudwatch.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "cw_firehose_role" {
  name        = "${var.prefix}-${var.stage}-${var.application}-firehose-iam-role"
  description = "IAM Role for for CloudWatch metric stream to Kinesis Firehose"

  assume_role_policy = data.aws_iam_policy_document.cw_firehose_role.json
}

# IAM Policy for
data "aws_iam_policy_document" "kinesis_streams_settings" {
  statement {
    sid    = "AllowKinesisDataFirehoseDeliveryStreamforCloudWatch"
    effect = "Allow"
    actions = [
      "firehose:PutRecord",
      "firehose:PutRecordBatch"
    ]
    resources = [aws_kinesis_firehose_delivery_stream.destination.arn]
  }
}

resource "aws_iam_role_policy" "kinesis_streams_settings" {
  name   = "${var.prefix}-${var.stage}-${var.application}-firehose-iam-ploicy"
  role   = aws_iam_role.cw_firehose_role.id
  policy = data.aws_iam_policy_document.kinesis_streams_settings.json
}
