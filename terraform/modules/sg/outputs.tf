output "my_public_ip" {
  value = "${chomp(data.http.my_public_ip.body)}/32"
}

output "bastion_sg_id" {
  value = aws_security_group.bastion-sg.id
}

output "exlb_sg_id" {
  value = aws_security_group.exlb-sg.id
}

output "web_sg_id" {
  value = aws_security_group.web-sg.id
}

output "inlb_sg_id" {
  value = aws_security_group.inlb-sg.id
}

output "was_sg_id" {
  value = aws_security_group.was-sg.id
}

output "db_sg_id" {
  value = aws_security_group.db-sg.id
}