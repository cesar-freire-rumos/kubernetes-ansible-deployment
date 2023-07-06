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

variable "access_key" {
  description = "SSH Access key"
  default     = "ubuntu@ubuntu-key-20220301"
}