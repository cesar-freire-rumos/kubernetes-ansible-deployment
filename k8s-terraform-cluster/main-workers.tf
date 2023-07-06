

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

  connection {
    type        = "ssh"
    user        = "${var.user}"
    private_key = file("./ubuntu-key-20220301.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "./ansible"
    destination = "/home/${var.user}"
  }


   provisioner "remote-exec" {
    inline = [
      "chmod +x /home/${var.user}/ansible/deploy-workers.sh",
      "/home/${var.user}/ansible/deploy-workers.sh",
    ]
  }
}

