provider "aws" {
  region     = var.aws_region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_instance" "my-server" {
  instance_type = "t2.medium"
  ami           = "ami-04e601abe3e1a910f"
  key_name      = var.access_key
}
