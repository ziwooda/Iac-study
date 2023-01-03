resource "tls_private_key" "tf-key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "tf-public-key" {
  key_name   = "tf-${element(var.key_div, 0)}-key"
  public_key = tls_private_key.tf-key.public_key_openssh
}

resource "local_file" "ssh-public-key" {
  filename = "${aws_key_pair.tf-public-key.key_name}.pem"
  content = tls_private_key.tf-key.private_key_pem
}

resource "aws_key_pair" "tf-private-key" {
  key_name   = "tf-${element(var.key_div, 1)}-key"
  public_key = tls_private_key.tf-key.public_key_openssh
}

resource "local_file" "ssh-private-key" {
  filename = "${aws_key_pair.tf-private-key.key_name}.pem"
  content = tls_private_key.tf-key.private_key_pem
}