resource "aws_s3_bucket" "app_data" {
  bucket = "${var.project_name}-app-data-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name = "${var.project_name}-app-data"
  }
}

resource "aws_s3_bucket_versioning" "app_data" {
  bucket = aws_s3_bucket.app_data.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "app_data" {
  bucket = aws_s3_bucket.app_data.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "app_data" {
  bucket                  = aws_s3_bucket.app_data.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "ams_trusted_remediator_logs" {
  bucket = "ams-trusted-remediator-${data.aws_caller_identity.current.account_id}-logs"
}

resource "aws_s3_bucket_versioning" "ams_trusted_remediator_logs" {
  bucket = aws_s3_bucket.ams_trusted_remediator_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "ams_trusted_remediator_logs" {
  bucket                  = aws_s3_bucket.ams_trusted_remediator_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ams_trusted_remediator_logs" {
  bucket = aws_s3_bucket.ams_trusted_remediator_logs.id
  rule {
    apply_server_side_encryption_by_default {
      # Uses the AWS-managed aws/s3 key (SSE-KMS default), consistent with the
      # app_data bucket pattern. Replace kms_master_key_id with a CMK ARN if
      # customer-managed key control is required.
      sse_algorithm = "aws:kms"
    }
  }
}
