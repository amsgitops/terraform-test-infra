variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "test"
}

variable "project_name" {
  description = "Project name prefix for all resources"
  type        = string
  default     = "codekeeper-test"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
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
  type        = string
  default     = "t3.micro"
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "alarm_email" {
  description = "Email address for CloudWatch alarm SNS notifications. Must be a real, non-placeholder address."
  type        = string
  # No default — callers must supply a value explicitly.

  validation {
    condition     = can(regex("^[^@]+@[^@]+\\.[^@]+$", var.alarm_email)) && var.alarm_email != "alerts@example.com"
    error_message = "alarm_email must be a valid, non-placeholder email address (e.g. ops@yourcompany.com)."
  }
}
