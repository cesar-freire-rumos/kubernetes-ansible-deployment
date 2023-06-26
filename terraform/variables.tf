# AWS credentials

variable "aws_access_key" {
  type = string
  description = "AWS access key"
}

variable "aws_secret_key" {
  type = string
  description = "AWS secret key"
}

variable "aws_region" {
  type = string
  description = "AWS region"
}

# NOTE: "terraform.tfvars" with AWS credentials is not commited to
#       git repository duw to security considerations
#
# Example:
# AWS Settings
# aws_access_key = "AKIxxxxxxxxxxxxxxxxxxxxxxxx"
# aws_secret_key = "Ssxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
# aws_region     = "eu-central-1"
