resource "aws_s3_bucket" "app_data" {
  bucket = "${var.project_name}-app-data-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "${var.project_name}-app-data"
    Environment = var.environment
    Project     = var.project_name
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

# Short-term test data bucket
resource "aws_s3_bucket" "codekeeper_warn_test_bucket_1779" {
  bucket = "${var.project_name}-warn-test-1779-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "${var.project_name}-warn-test-1779"
    Environment = var.environment
    Project     = var.project_name
  }
}

resource "aws_s3_bucket_versioning" "codekeeper_warn_test_bucket_1779" {
  bucket = aws_s3_bucket.codekeeper_warn_test_bucket_1779.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "codekeeper_warn_test_bucket_1779" {
  bucket = aws_s3_bucket.codekeeper_warn_test_bucket_1779.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "codekeeper_warn_test_bucket_1779" {
  bucket                  = aws_s3_bucket.codekeeper_warn_test_bucket_1779.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
