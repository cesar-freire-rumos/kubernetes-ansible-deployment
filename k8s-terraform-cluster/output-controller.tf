output "remote_login_controler" {
  value = "ssh ubuntu@${aws_instance.k8s-controller.public_ip} -i ubuntu-key-20220301.pem"
}