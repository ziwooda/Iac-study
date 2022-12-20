output "vpc_id" {
  value = aws_vpc.tf-vpc.id
  description = "vpc id"
}

output "availability_zone" {
  value = var.availability_zone
  description = "availability zones"
}

output "public_subnet_id" {
    value = [aws_subnet.public_subnet[*].id]
    description = "public subnet ids"
}

output "public_subnet_cidr_block" {
    value = [aws_subnet.public_subnet[*].cidr_block]
    description = "cidr block of public subnet"
}

output "web_subnet_id" {
  value = [aws_subnet.web_subnet[*].id]
  description = "private subnet ids"
}

output "web_subnet_cidr_block" {
  value = [aws_subnet.web_subnet[*].cidr_block]
  description = "cidr block of web subnet"
}

output "was_private_subnet_id" {
  value = [aws_subnet.was_subnet[*].id]
  description = "private subnet ids"
}

output "was_subnet_cidr_block" {
  value = [aws_subnet.was_subnet[*].cidr_block]
  description = "cidr block of was subnet"
}

output "rds_subnet_id" {
  value = [aws_subnet.rds_subnet[*].id]
  description = "private subnet ids"
}

output "rds_subnet_cidr_block" {
  value = [aws_subnet.rds_subnet[*].cidr_block]
  description = "cidr block of rds subnet"
}

