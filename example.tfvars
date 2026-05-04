# example.tfvars
# Copy this file to terraform.tfvars and fill in values appropriate for your environment.
# Do NOT commit terraform.tfvars to source control if it contains sensitive data.

# ---------------------------------------------------------------------------
# Required — must be set explicitly; no defaults are provided.
# ---------------------------------------------------------------------------

# List of CIDR blocks allowed to SSH (port 22) to the bastion host.
# Restrict this to your organisation's egress IPs or VPN CIDR.
# Open-world values (0.0.0.0/0, ::/0) are rejected by variable validation.
# Example value shown below — replace with your actual trusted ranges.
bastion_allowed_cidrs = ["203.0.113.0/24"] # Replace with your trusted operator IP range

# Name of an existing EC2 key pair in the target AWS region for bastion SSH access.
bastion_key_name = "my-operator-keypair" # Replace with your actual key pair name

# ---------------------------------------------------------------------------
# Optional overrides — defaults are defined in variables.tf
# ---------------------------------------------------------------------------

# region        = "us-west-2"
# environment   = "test"
# project_name  = "codekeeper-test"
# vpc_cidr      = "172.16.0.0/16"

# public_subnet_cidrs  = ["172.16.1.0/24", "172.16.2.0/24"]
# private_subnet_cidrs = ["172.16.10.0/24", "172.16.11.0/24"]

# enable_nat_gateway = false
# instance_type      = "t3.micro"
# db_instance_class  = "db.t3.micro"
# db_name            = "appdb"
# alarm_email        = "alerts@example.com"
