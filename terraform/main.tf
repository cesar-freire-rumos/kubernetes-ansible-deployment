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
        Environment = "Test"
        server_type = "testing"
        client = "rumos"
    }

    vpc_security_group_ids = [
        "default",
        "${aws_security_group.instance_ports.id}",
        ]
} 

resource "aws_security_group" "instance_ports" {
    name = "allow_instance_ports"
    description = "Allow instance frontend ports"
    ingress {
        description = "Ports to open on all instances"
        from_port = "${var.instance_ports}"
        to_port = "${var.instance_ports}"
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "allow_instance_ports"
  }
}

output "public_ip" {
    value = "${aws_instance.k8s[*].public_ip}"
}
