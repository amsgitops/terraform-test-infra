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
  default     = "172.16.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = ["172.16.1.0/24", "172.16.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
  default     = ["172.16.10.0/24", "172.16.11.0/24"]
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
  description = "Email for CloudWatch alarm notifications"
  default     = "alerts@example.com"
}

variable "bastion_key_name" {
  description = "EC2 key pair name for bastion SSH access"
  type        = string
}

variable "admin_cidr" {
  description = "CIDR block allowed to SSH into the bastion host (e.g. corporate egress IP)"
  type        = string

  validation {
    condition = (
      var.admin_cidr != "0.0.0.0/0" &&
      var.admin_cidr != "::/0" &&
      tonumber(split("/", var.admin_cidr)[1]) >= 16
    )
    error_message = "admin_cidr must be a specific CIDR with a prefix length of at least /16 (e.g. 203.0.113.0/24). Open ranges like 0.0.0.0/0 are not permitted."
  }
}
