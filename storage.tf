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

resource "aws_s3_bucket" "ams_trusted_remediator_logs" {
  bucket = "ams-trusted-remediator-${data.aws_caller_identity.current.account_id}-logs"

  tags = {
    Name = "ams-trusted-remediator-logs"
  }
}

resource "aws_s3_bucket_versioning" "ams_trusted_remediator_logs" {
  bucket = aws_s3_bucket.ams_trusted_remediator_logs.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ams_trusted_remediator_logs" {
  bucket = aws_s3_bucket.ams_trusted_remediator_logs.id
  rule {
    apply_server_side_encryption_by_default {
      # Using a customer-managed KMS key for fine-grained key policy control
      # and custom rotation schedule. Set var.logs_kms_key_id to the CMK ARN/ID.
      sse_algorithm     = "aws:kms"
      kms_master_key_id = var.logs_kms_key_id
    }
  }
}

resource "aws_s3_bucket_public_access_block" "ams_trusted_remediator_logs" {
  bucket                  = aws_s3_bucket.ams_trusted_remediator_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "ams_trusted_remediator_logs" {
  bucket = aws_s3_bucket.ams_trusted_remediator_logs.id

  rule {
    id     = "expire-old-logs"
    status = "Enabled"

    expiration {
      days = 365
    }

    noncurrent_version_expiration {
      noncurrent_days = 90
    }
  }
}

data "aws_caller_identity" "current" {}
