# Terraform simple example

1. Add `ansible folder`
2. add playbook and installer script
3. Change `main.tf` to include remote-exec
4. Add `ubuntu-key-20220301.pem` to allow remote login
5. Type `terraform init`
6. Type `terraform apply`
7. `ssh -i ~/.ssh/ubuntu-key-20220301.pem ubuntu@<public_ip>`
8. Type `hostamectl`
9. Destroy instance with `terraform destroy`

