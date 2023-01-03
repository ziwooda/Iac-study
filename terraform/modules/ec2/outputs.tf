output "bastion_instance_id" {
  value = aws_instance.bastion-host.id
}

output "web_instance_id" {
  value = aws_instance.tf-was[*].id
}

output "was_instance_id" {
  value = aws_instance.tf-was[*].id
}

output "db_instance_id" {
  value = aws_instance.tf-db[*].id
}