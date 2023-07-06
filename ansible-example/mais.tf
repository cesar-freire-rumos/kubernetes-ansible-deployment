provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "my-server" {
  instance_type = "t2.medium"
  ami           = "ami-04e601abe3e1a910f"
  key_name      = var.access_key

## begin ansible block ##

  vpc_security_group_ids = [
    "default",
  ]

   connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./ubuntu-key-20220301.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "./ansible"
    destination = "/home/ubuntu"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/ansible/install-ansible.sh",
      "/home/ubuntu/ansible/install-ansible.sh",
    ]
  }
  ## end ansible block ##
}
