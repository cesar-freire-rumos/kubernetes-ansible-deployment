provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "k8s" {
    count           = length(var.instance_names)
    instance_type   = "${var.instance_type}"
    ami             = "${var.instance_image}"
    key_name        = "${var.access_key}"
    tags = {
        Name = "${var.instance_prefix}-${element(var.instance_names, count.index)}"
    }

    vpc_security_group_ids = [
        "default"
        ]
} 

output "public_ip" {
    value = "${aws_instance.k8s[*].public_ip}"
}
