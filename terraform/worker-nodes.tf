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

output "remote_login_instances" {
  value =  [
    for vm_instance in aws_instance.k8s : 
      "ssh ubuntu@${vm_instance.public_ip} -i ubuntu-key-20220301.pem"
  ] 
}
