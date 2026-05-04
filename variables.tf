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
  type        = string
  default     = "172.16.0.0/16"
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr must be a valid CIDR block."
  }
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = ["172.16.1.0/24", "172.16.2.0/24"]
  validation {
    condition     = alltrue([for c in var.public_subnet_cidrs : can(cidrhost(c, 0))])
    error_message = "All public_subnet_cidrs must be valid CIDR blocks."
  }
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
  default     = ["172.16.10.0/24", "172.16.11.0/24"]
  validation {
    condition     = alltrue([for c in var.private_subnet_cidrs : can(cidrhost(c, 0))])
    error_message = "All private_subnet_cidrs must be valid CIDR blocks."
  }
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type        = bool
  default     = false
}

variable "bastion_allowed_cidrs" {
  description = "CIDR blocks permitted to SSH into the bastion host"
  type        = list(string)
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
  description = "Email for CloudWatch alarm notifications"
  default     = "alerts@example.com"
}
