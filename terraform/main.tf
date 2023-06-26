provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "cfreire-tf" {
    instance_type   = "${var.instance_type}"
    ami             = "${var.instance_image}"
    key_name        = "${var.access_key}"

    vpc_security_group_ids = [
        "default"
        ]
} 

