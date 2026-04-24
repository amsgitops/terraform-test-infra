# Copy this file to terraform.tfvars and fill in the required values before
# running terraform plan/apply. Do NOT commit terraform.tfvars to source control.

# Required: Specific trusted CIDR permitted to SSH to the bastion host.
# Must be a valid CIDR — open ranges (0.0.0.0/0) are rejected by validation.
# Example: "203.0.113.10/32"
bastion_allowed_cidr = "REPLACE_WITH_YOUR_TRUSTED_CIDR/32"

# Required: Name of an existing EC2 key pair in the target AWS account/region
# to assign to the bastion host for SSH access.
# Example: "my-ops-keypair"
bastion_key_name = "REPLACE_WITH_YOUR_KEY_PAIR_NAME"
