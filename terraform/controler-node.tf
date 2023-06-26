provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "k8s-controler" {
  instance_type = var.instance_type
  ami           = data.aws_ami.ubuntu.id
  key_name      = var.access_key
  tags = {
    Name        = "${var.instance_prefix}-controler"
    Environment = "Test"
    Terraform   = "true"
    Project     = "Ansible conference"
    Entity      = "RUMOS"
  }

  vpc_security_group_ids = [
    "default",
    "${aws_security_group.instance_ports.id}",
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./ubuntu-key-20220301.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "./ansible/"
    destination = "~/ansible"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/ansible/setup-ansible-controler.sh",
      "~/setup-ansible-controler.sh",
    ]
  }
}

resource "aws_security_group" "instance_ports" {
  name        = "allow_instance_ports"
  description = "Allow instance frontend ports"
  ingress = [
    {
      description      = "HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      self             = false
      security_groups  = []
      prefix_list_ids  = []
    },
    {
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      self             = false
      security_groups  = []
      prefix_list_ids  = []
    }
  ]
  tags = {
    Environment = "Test"
    Terraform   = "true"
    Name        = "allow_instance_ports"
    Project     = "Ansible conference"
    Entity      = "RUMOS"
  }
}


output "controler-public_ip" {
  value = aws_instance.k8s-controler[*].public_ip
}
