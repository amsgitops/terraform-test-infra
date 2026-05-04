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

variable "trusted_ssh_cidr" {
  description = "Trusted external CIDR allowed to SSH into the bastion host (e.g. your corporate egress IP: \"203.0.113.10/32\")"
  type        = string

  validation {
    condition     = !contains(["0.0.0.0/0", "::/0"], var.trusted_ssh_cidr)
    error_message = "trusted_ssh_cidr must not be 0.0.0.0/0 or ::/0. Provide a specific trusted CIDR (e.g. \"203.0.113.10/32\")."
  }
}

variable "bastion_key_name" {
  description = "Name of the EC2 key pair to use for bastion SSH access"
  type        = string
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
