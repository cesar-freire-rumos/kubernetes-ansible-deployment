output "public_ip" {
  value = "${aws_instance.my-server.public_ip}"
}