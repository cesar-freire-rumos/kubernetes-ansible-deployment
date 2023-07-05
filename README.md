# kubernetes-ansible-deployment
Deploy a production grade kubernetes cluster using terraform and ansible

_20230626 | César Bento Freire | <cesar.freire@training.rumos.pt>_


---
## AWS setup


__Create a aws account at__

https://aws.amazon.com/pt/

__Export Access keys__

Profile >> Security credentials >> Access keys

NOTE: Best practices suggests to create  new user with temporary access keys

---

## Local setup

### SSH Keys

__Create a ssh key if not exist__

        $ ssh-keygen

__Copy private and public keys to ansible folder__

        cp ~/.ssh/id_rsa* terraform/ansible

### Terraform setup

__Initialize terraform provider__

        $ terraform init

__Create a file `terraform.tfvars` and add your credentials__

```
# AWS Settings
# user: cfreire-aws-tf
aws_access_key = "AKIAxxxxxxxxxxxxxxxxx"
aws_secret_key = "Ssxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
aws_region     = "eu-central-1"

```

__Apply terraform plan__

        $ terraform apply


## Ansible setup

