# bastion host sg rules
data "http" "my_public_ip" {
  url = "https://ipv4.icanhazip.com/"
}

locals {
  ssh_ingress  = {
    type = "ingress"
    ssh_from_port = 22
    ssh_to_port   = 22
    protocol      = "tcp"
    all_ips       = ["0.0.0.0/0"]
  }

  http_ingress = {
    type = "ingress"
    http_from_port = 80
    http_to_port   = 80
    protocol       = "tcp"
  }

  egress = {
    type = "egress"
    ssh_from_port = 0
    ssh_to_port   = 0
    protocol      = "-1"
    all_ips       = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "bastion-ssh-ingress" {
  type              = local.ssh_ingress.type
  from_port         = local.ssh_ingress.ssh_from_port
  to_port           = local.ssh_ingress.ssh_to_port
  protocol          = local.ssh_ingress.protocol
  cidr_blocks       = local.ssh_ingress.all_ips
  security_group_id = aws_security_group.bastion-sg.id

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "bastion-http-ingress" {
  type              = local.http_ingress.type
  from_port         = local.http_ingress.http_from_port
  to_port           = local.http_ingress.http_to_port
  protocol          = local.http_ingress.protocol
  cidr_blocks       = ["${chomp(data.http.my_public_ip.body)}/32"] # to-do: attribute 'body' deprecated
  security_group_id = aws_security_group.bastion-sg.id

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "bastion-egress" {
  type              = local.egress.type
  from_port         = local.egress.ssh_from_port
  to_port           = local.egress.ssh_to_port
  protocol          = local.egress.protocol
  cidr_blocks       = local.egress.all_ips
  security_group_id = aws_security_group.bastion-sg.id

  lifecycle { create_before_destroy = true }
}

# external load balancer sg rules
resource "aws_security_group_rule" "exlb-http-ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.exlb-sg.id

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "exlb-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.exlb-sg.id

  lifecycle { create_before_destroy = true }
}

# web sg rules
resource "aws_security_group_rule" "web-ssh-ingress" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web-sg.id
  source_security_group_id = aws_security_group.bastion-sg.id
  description              = "bastion host"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "web-http-ingress" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web-sg.id
  source_security_group_id = aws_security_group.exlb-sg.id
  description              = "external-lb"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "web-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web-sg.id

  lifecycle { create_before_destroy = true }
}

# internal load balancer sg rules
resource "aws_security_group_rule" "inlb-http-ingress" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.inlb-sg.id
  source_security_group_id = aws_security_group.web-sg.id
  description              = "web-sg"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "inlb-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.inlb-sg.id

  lifecycle { create_before_destroy = true }
}

# was sg rules
resource "aws_security_group_rule" "was-ssh-ingress" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.was-sg.id
  source_security_group_id = aws_security_group.bastion-sg.id
  description              = "bastion host"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "was-http-ingress" {
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = aws_security_group.was-sg.id
  source_security_group_id = aws_security_group.inlb-sg.id
  description              = "internall-lb"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "was-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.was-sg.id

  lifecycle { create_before_destroy = true }
}

# db sg rules
resource "aws_security_group_rule" "db-ssh-ingress" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = aws_security_group.db-sg.id
  source_security_group_id = aws_security_group.bastion-sg.id
  description              = "bastion host"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "db-mysql-ingress" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.db-sg.id
  source_security_group_id = aws_security_group.was-sg.id
  description              = "was server"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "db-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.db-sg.id

  lifecycle { create_before_destroy = true }
}