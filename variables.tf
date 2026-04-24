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

# 172.16.0.0/16 is a valid RFC 1918 range chosen intentionally for this VPC.
# Before peering or connecting via VPN/Direct Connect, verify this range does
# not overlap with any on-premises or partner network (172.16.0.0/16 is
# commonly used in corporate environments).
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

variable "bastion_allowed_cidr" {
  description = "CIDR block permitted to SSH to the bastion host. Must be a valid, specific trusted operator range (e.g. corporate egress IP or VPN CIDR). Open ranges (0.0.0.0/0 or ::/0) are rejected."
  type        = string

  validation {
    condition = (
      can(cidrnetmask(var.bastion_allowed_cidr)) &&
      !contains(["0.0.0.0/0", "::/0"], var.bastion_allowed_cidr)
    )
    error_message = "bastion_allowed_cidr must be a valid CIDR block and must not be an open range (0.0.0.0/0 or ::/0). Provide a specific trusted range, e.g. \"203.0.113.10/32\"."
  }
}

variable "bastion_key_name" {
  description = "Name of the EC2 key pair to assign to the bastion host for SSH access."
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
