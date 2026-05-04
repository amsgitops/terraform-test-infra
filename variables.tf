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
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "vpc_cidr must be a valid CIDR block (e.g. 172.16.0.0/16)."
  }
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDR blocks"
  type        = list(string)
  default     = ["172.16.1.0/24", "172.16.2.0/24"]

  validation {
    condition     = alltrue([for cidr in var.public_subnet_cidrs : can(cidrnetmask(cidr))])
    error_message = "All public_subnet_cidrs must be valid CIDR blocks."
  }
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDR blocks"
  type        = list(string)
  default     = ["172.16.10.0/24", "172.16.11.0/24"]

  validation {
    condition     = alltrue([for cidr in var.private_subnet_cidrs : can(cidrnetmask(cidr))])
    error_message = "All private_subnet_cidrs must be valid CIDR blocks."
  }
}

variable "bastion_allowed_cidrs" {
  description = "CIDR blocks permitted to SSH to the bastion host. Must be restricted to trusted operator IPs (e.g. corporate egress or VPN CIDR). At least one entry is required; open-world CIDRs (0.0.0.0/0, ::/0) are rejected."
  type        = list(string)

  validation {
    condition = (
      length(var.bastion_allowed_cidrs) > 0 &&
      alltrue([for cidr in var.bastion_allowed_cidrs : can(cidrnetmask(cidr))]) &&
      !contains(var.bastion_allowed_cidrs, "0.0.0.0/0") &&
      !contains(var.bastion_allowed_cidrs, "::/0")
    )
    error_message = "bastion_allowed_cidrs must contain at least one valid CIDR block and must not be open to the world (0.0.0.0/0 or ::/0)."
  }
}

variable "bastion_key_name" {
  description = "Name of the EC2 key pair to use for SSH access to the bastion host. The key pair must already exist in the target AWS region."
  type        = string
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
