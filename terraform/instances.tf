variable "instance_prefix" {
  description = "Prefix all instances with..."
  default     = "k8s"
}

variable "instance_names" {
  description = "Names of instances"
  default     = ["node1", "node2"]
}

variable "instance_type" {
  description = "Family: t2 1 vCPU 1GiB Memory"
  default     = "t2.micro"
}


variable "access_key" {
  description = "SSH Access key"
  default     = "ubuntu@ubuntu-key-20220301"
}

# Find latest image id

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
