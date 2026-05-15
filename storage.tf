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

# -----------------------------------------------------------------------
# TEST RESOURCE — intentionally insecure for Checkov gate validation.
# No encryption and all public-access-block controls disabled.
# Only created when var.enable_checkov_test_resources = true (never in
# deployed environments). DO NOT use in production.
#
# Expected Checkov findings (canary check IDs):
#   CKV_AWS_19  — S3 bucket not encrypted
#   CKV_AWS_20  — S3 bucket allows public ACLs
#   CKV_AWS_53  — S3 bucket has block public policy disabled
#   CKV2_AWS_6  — S3 bucket public access block not fully enabled
# -----------------------------------------------------------------------
resource "aws_s3_bucket" "checkov_test_public_unencrypted" {
  #checkov:skip=CKV_AWS_19:Intentional - Checkov gate canary resource, no encryption by design
  #checkov:skip=CKV_AWS_20:Intentional - Checkov gate canary resource, public ACLs by design
  #checkov:skip=CKV_AWS_53:Intentional - Checkov gate canary resource, block public policy disabled by design
  #checkov:skip=CKV2_AWS_6:Intentional - Checkov gate canary resource, public access block disabled by design
  count  = var.enable_checkov_test_resources ? 1 : 0
  bucket = "checkov-test-canary-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name    = "checkov-test-bucket-public-unencrypted"
    Purpose = "checkov-gate-canary-DO-NOT-USE"
  }
}

resource "aws_s3_bucket_public_access_block" "checkov_test_public_unencrypted" {
  #checkov:skip=CKV2_AWS_6:Intentional - Checkov gate canary resource, public access block disabled by design
  count                   = var.enable_checkov_test_resources ? 1 : 0
  bucket                  = aws_s3_bucket.checkov_test_public_unencrypted[count.index].id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
