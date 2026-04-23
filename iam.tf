resource "aws_iam_role" "web_server" {
  name = "${var.project_name}-web-server-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })

  tags = {
    Name = "${var.project_name}-web-server-role"
  }
}

resource "aws_iam_role_policy" "web_s3_access" {
  name = "${var.project_name}-web-s3-access"
  role = aws_iam_role.web_server.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.app_data.arn,
          "${aws_s3_bucket.app_data.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy" "web_ssm_access" {
  name = "${var.project_name}-web-ssm-access"
  role = aws_iam_role.web_server.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ssm:GetParameter",
          "ssm:GetParameters"
        ]
        Resource = "arn:aws:ssm:${var.region}:*:parameter/${var.project_name}/*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "web_server" {
  name = "${var.project_name}-web-server-profile"
  role = aws_iam_role.web_server.name
}
