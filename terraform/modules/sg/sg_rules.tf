# bastion-sg
data "http" "my_public_ip" {
  url = "https://ipv4.icanhazip.com/"
}

resource "aws_security_group_rule" "bastion-ssh-ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.bastion-sg.id}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "bastion-http-ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["${chomp(data.http.my_public_ip.body)}/32"]
  security_group_id = "${aws_security_group.bastion-sg.id}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "bastion-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.bastion-sg.id}"

  lifecycle { create_before_destroy = true }
}

# exlb-sg
resource "aws_security_group_rule" "exlb-http-ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.exlb-sg.id}"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "exlb-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.exlb-sg.id}"

  lifecycle { create_before_destroy = true }
}

# web-sg
resource "aws_security_group_rule" "web-ssh-ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.web-sg.id}"
  source_security_group_id = "${aws_security_group.bastion-sg.id}"
  description       = "bastion host"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "web-http-ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.web-sg.id}"
  source_security_group_id = "${aws_security_group.exlb-sg.id}"
  description       = "external-lb"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "web-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.web-sg.id}"

  lifecycle { create_before_destroy = true }
}

# inlb-sg
resource "aws_security_group_rule" "inlb-http-ingress" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = "${aws_security_group.inlb-sg.id}"
  source_security_group_id = "${aws_security_group.web-sg.id}"
  description       = "web-sg"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "inlb-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.inlb-sg.id}"

  lifecycle { create_before_destroy = true }
}

# was-sg
resource "aws_security_group_rule" "was-ssh-ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.was-sg.id}"
  source_security_group_id = "${aws_security_group.bastion-sg.id}"
  description       = "bastion host"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "was-http-ingress" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = "${aws_security_group.was-sg.id}"
  source_security_group_id = "${aws_security_group.inlb-sg.id}"
  description       = "internall-lb"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "was-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.was-sg.id}"

  lifecycle { create_before_destroy = true }
}

# db-sg
resource "aws_security_group_rule" "db-ssh-ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.db-sg.id}"
  source_security_group_id = "${aws_security_group.bastion-sg.id}"
  description       = "bastion host"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "db-mysql-ingress" {
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = "${aws_security_group.db-sg.id}"
  source_security_group_id = "${aws_security_group.was-sg.id}"
  description       = "was server"

  lifecycle { create_before_destroy = true }
}

resource "aws_security_group_rule" "db-egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.db-sg.id}"

  lifecycle { create_before_destroy = true }
}