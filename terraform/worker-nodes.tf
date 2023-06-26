variable "worker_nodes" {
  description = "Number of worker nodes to deploy"
  default     = 1
}

resource "aws_instance" "k8s" {
  count         = "${var.worker_nodes}"
  instance_type = var.instance_type
  ami           = data.aws_ami.ubuntu.id
  key_name      = var.access_key
  tags = {
    Name        = "${var.instance_prefix}-node${count.index}"
    Environment = "Test"
    Terraform   = "true"
    Project     = "Ansible conference"
    Entity      = "RUMOS"
  }

  vpc_security_group_ids = [
    "default"
  ]
}

output "nodes-public_ip" {
  value = aws_instance.k8s[*].public_ip
}
