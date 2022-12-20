output "vpc_id" {
  value = aws_vpc.tf-vpc.id
}

output "availability_zone" {
  value = var.availability_zone
}