# Terraform simple example

1. Login to AWS Console
2. Goto IAM and create a user with `AdministratorAccess`
3. Create `access key`
4. Download credententials
5. Create `terraform.tfvars`
6. If using git add file to `.gitignore`
7. Add `variables.tf`
8. Add `main.tf`
9. Add `output.tf`
10. Type `terraform init`
11. Type `terraform apply`
12. `ssh -i ~/.ssh/ubuntu-key-20220301.pem ubuntu@<public-ip>`
13. Type `hostamectl`
14. Destroy instance with `terraform destroy`