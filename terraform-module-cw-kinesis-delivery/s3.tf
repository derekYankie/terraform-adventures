resource "aws_s3_bucket" "kinesis_failed_streams_bucket" {
  bucket = "${var.prefix}-${var.stage}-${var.application}-kinesis-failed-streams-${var.region}-bucket"

  tags = {
    Name = "${var.prefix}-${var.stage}-${var.application}-kinesis-failed-streams-${var.region}-bucket"
  }
}

resource "aws_s3_bucket_versioning" "enable_versioning" {
  bucket = aws_s3_bucket.kinesis_failed_streams_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.kinesis_failed_streams_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
