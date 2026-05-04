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
  default     = "172.16.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks. All entries must be valid CIDRs and must be subnets of var.vpc_cidr."
  type        = list(string)
  default     = ["172.16.1.0/24", "172.16.2.0/24"]

  validation {
    condition     = alltrue([for c in var.public_subnet_cidrs : can(cidrnetmask(c))])
    error_message = "All public_subnet_cidrs must be valid CIDR blocks."
  }
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks. All entries must be valid CIDRs and must be subnets of var.vpc_cidr."
  type        = list(string)
  default     = ["172.16.10.0/24", "172.16.11.0/24"]

  validation {
    condition     = alltrue([for c in var.private_subnet_cidrs : can(cidrnetmask(c))])
    error_message = "All private_subnet_cidrs must be valid CIDR blocks."
  }
}

variable "enable_nat_gateway" {
  description = "Enable NAT Gateway for private subnets"
  type        = bool
  default     = false
}

variable "bastion_allowed_cidr" {
  description = "CIDR block permitted to SSH into the bastion host. Must be a specific trusted external range (e.g. corporate VPN /32 or /24). No default is provided — this must be explicitly set."
  type        = string

  validation {
    condition = (
      can(cidrnetmask(var.bastion_allowed_cidr)) &&
      var.bastion_allowed_cidr != "0.0.0.0/0" &&
      var.bastion_allowed_cidr != "::/0"
    )
    error_message = "bastion_allowed_cidr must be a valid, non-wildcard CIDR block. Do not use 0.0.0.0/0."
  }
}

variable "bastion_key_name" {
  description = "Name of the EC2 key pair for bastion SSH access"
  type        = string
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
  description = "Email for CloudWatch alarm notifications"
  type        = string
  default     = "alerts@example.com"
}
