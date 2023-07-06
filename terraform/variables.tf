# Instance variables

variable "instance_prefix" {
  description = "Prefix all instances with..."
  default     = "k8s"
}

variable "worker_nodes" {
  description = "Number of worker nodes to deploy"
  default     = 2
}

variable "instance_type" {
  description = "Family: t2 2 vCPU 4GiB Memory"
  default     = "t2.medium"
}

variable "access_key" {
  description = "SSH Access key"
  default     = "ubuntu@ubuntu-key-20220301"
}

variable "user" {
  description = "Default user"
  default     = "ubuntu"
}

# Find latest ubuntu image id
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

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

