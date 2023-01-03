output "public-key-pair" {
  value = aws_key_pair.tf-public-key.key_name
}
output "private-key-pair" {
  value = aws_key_pair.tf-private-key.key_name
}
