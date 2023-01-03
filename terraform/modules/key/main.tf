resource "tls_private_key" "tf-key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "tf-key" {
  key_name   = "${var.key_tags}-tf-key"
  public_key = "${tls_private_key.tf-key.public_key_openssh}"
}

resource "local_file" "ssh-key" {
  filename = "${aws_key_pair.tf-key.key_name}.pem"
  content = tls_private_key.tf-key.private_key_pem
}