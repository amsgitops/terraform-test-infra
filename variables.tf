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
  default     = "CodeKeeper E2E 1778731955"
}

variable "load_test_tag" {
  description = "Opaque identifier assigned by the load-testing platform. Applied as the 'LoadTestTag' tag on the target public subnet (index var.load_test_subnet_index, CIDR 10.0.2.0/24) to allow the platform to discover the subnet. Must be supplied explicitly per load-test run — do not commit a live job ID as a default."
  type        = string
  # No default — must be supplied explicitly via .tfvars, environment variable,
  # or CI pipeline input to avoid silently tagging with a stale job ID.
}

variable "load_test_subnet_index" {
  description = "Index of the public subnet (aws_subnet.public[*]) to which the LoadTestTag is applied. Index 1 corresponds to CIDR 10.0.2.0/24 (the non-web/bastion public subnet). Index 0 is reserved for the web/bastion subnet (CIDR 10.0.1.0/24). Bounds are enforced by a lifecycle precondition on aws_subnet.public."
  type        = number
  default     = 1
}
