variable "instance_prefix" {
  description = "Prefix all instances with..."
  default     = "k8s"
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
