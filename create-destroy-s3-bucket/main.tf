resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.s3_bucket
  force_destroy = true
  acl           = "private"
  lifecycle {
    prevent_destroy = false
  }
  versioning {
    enabled = false
  }
  tags = var.default_tags
}

resource "aws_s3_bucket_public_access_block" "public-access-block" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
