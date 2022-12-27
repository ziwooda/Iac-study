output "my_public_ip" {
  value = "${chomp(data.http.my_public_ip.body)}/32"
}