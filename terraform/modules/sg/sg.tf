resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "security group of bastion host"
  vpc_id      = var.vpc_id

  tags = {
    Name = "bastion-sg"
  }
}

resource "aws_security_group" "exlb-sg" {
  name        = "exlb-sg"
  description = "security group of external load balancer"
  vpc_id      = var.vpc_id

  tags = {
    Name = "exlb-sg"
  }
}

resource "aws_security_group" "web-sg" {
  name        = "web-sg"
  description = "security group of web server"
  vpc_id      = var.vpc_id

  tags = {
    Name = "web-sg"
  }
}

resource "aws_security_group" "inlb-sg" {
  name        = "inlb-sg"
  description = "security group of internal load balancer"
  vpc_id      = var.vpc_id

  tags = {
    Name = "inlb-sg"
  }
}

resource "aws_security_group" "was-sg" {
  name        = "was-sg"
  description = "security group of was"
  vpc_id      = var.vpc_id

  tags = {
    Name = "was-sg"
  }
}

resource "aws_security_group" "db-sg" {
  name        = "db-sg"
  description = "security group of db instances"
  vpc_id      = var.vpc_id

  tags = {
    Name = "db-sg"
  }
}