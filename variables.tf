variable "region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "test"

  validation {
    condition     = contains(["checkov", "ci", "test", "staging", "production"], lower(var.environment))
    error_message = "environment must be one of: checkov, ci, test, staging, production."
  }
}

variable "project_name" {
  description = "Project name prefix for all resources"
  default     = "codekeeper-test"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type        = bool
  default     = false
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "db_instance_class" {
  description = "RDS instance class"
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Database name"
  default     = "appdb"
}

variable "alarm_email" {
  description = "Email address for CloudWatch alarm notifications"
  default     = "alerts@example.com"
}

variable "sns_display_name" {
  description = "Display name for the SNS alerts topic (visible in email/SMS subjects)"
  type        = string
  default     = "CodeKeeper E2E 1778809671"
}

variable "enable_checkov_test_resources" {
  description = "Set to true only in static-analysis / Checkov gate pipelines. Never true in deployed environments."
  type        = bool
  default     = false

  validation {
    condition     = var.enable_checkov_test_resources == false || length(regexall("^(checkov|ci|test)$", lower(var.environment))) > 0
    error_message = "enable_checkov_test_resources must only be true in checkov/ci/test environments, never in deployed environments."
  }
}
