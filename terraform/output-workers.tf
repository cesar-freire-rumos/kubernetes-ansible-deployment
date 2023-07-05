output "remote_login_instances" {
  value =  [
    for vm_instance in aws_instance.k8s : 
      "ssh ubuntu@${vm_instance.public_ip} -i ubuntu-key-20220301.pem"
  ] 
}
