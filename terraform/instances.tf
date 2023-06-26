variable "instance_prefix" {
  description = "Prefix all instances with..."
  default     = "k8s"
}

variable "instance_names" {
  description = "Names of instances"
  default     = ["node1", "node2"]
}

variable "instance_image" {
  description = "Ubuntu Server 22.04 LTS (HVM), SSD Volume Type"
  default     = "ami-04e601abe3e1a910f"
}

variable "instance_type" {
  description = "Family: t2 1 vCPU 1GiB Memory"
  default     = "t2.micro"
}

variable "access_key" {
  description = "SSH Access key"
  default     = "ubuntu@ubuntu-key-20220301"
}

