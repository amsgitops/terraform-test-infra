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

variable "bastion_allowed_cidrs" {
  description = "List of trusted external CIDR blocks permitted to SSH (port 22) to the bastion host"
  type        = list(string)

  validation {
    condition     = length(var.bastion_allowed_cidrs) > 0
    error_message = "bastion_allowed_cidrs must contain at least one CIDR block. Do not leave this empty in production."
  }
}

variable "bastion_key_name" {
  description = "Name of the EC2 key pair to associate with the bastion host for SSH access"
  type        = string

  validation {
    condition     = var.bastion_key_name != ""
    error_message = "bastion_key_name must be set to a valid EC2 key pair name."
  }
}

variable "bastion_instance_type" {
  description = "EC2 instance type for the bastion host"
  type        = string
  default     = "t3.micro"
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
