variable "region" {
  description = "AWS region"
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name"
  default     = "test"
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
  default     = "CodeKeeper E2E 1778728280"
}

variable "load_test_tag" {
  description = "Load test run identifier (e.g. CI pipeline run ID) applied exclusively to the first private subnet (private_subnet_cidrs[0]). Must be explicitly set per load test run."
  type        = string
  # No default: this must be supplied explicitly per run to avoid stale IDs.
}
