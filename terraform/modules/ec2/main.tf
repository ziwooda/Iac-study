data "aws_ami" "tf-ami" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# bastion host
resource "aws_instance" "bastion-host" {
  ami           = data.aws_ami.tf-ami.id
  instance_type = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids = [
    var.bastion_sg
  ]

  availability_zone = "${element(var.availability_zone, 0)}"
  subnet_id = var.bastion_subnet[0]
  key_name  = "${element(var.key, 0)}"

  root_block_device {
    volume_size = var.ebs_size
    volume_type = var.ebs_type
    tags = {
      "Name" = "${var.env}-bastion-volume"
    }
  }

  tags = {
    "Name" = "${var.env}-bastion-host"
  }
}

# web instances
resource "aws_instance" "tf-was" {
  count         = "${length(var.availability_zone)}"
  ami           = data.aws_ami.tf-ami.id
  instance_type = var.instance_type
  vpc_security_group_ids = [
    var.was_sg
  ]

  availability_zone = "${element(var.availability_zone, count.index)}"
  subnet_id = "${element(var.was_subnet, count.index)}"
  key_name  = "${element(var.key, 1)}"

  root_block_device {
    volume_size = var.ebs_size
    volume_type = var.ebs_type
    tags = {
      "Name" = "${var.env}-was-volume-${count.index+1}"
    }
  }

  tags = {
    "Name" = "${var.env}-was-${count.index+1}"
  }
}

# was instances
resource "aws_instance" "tf-db" {
  count         = "${length(var.availability_zone)}"
  ami           = data.aws_ami.tf-ami.id
  instance_type = var.instance_type
  vpc_security_group_ids = [
    var.db_sg
  ]

  availability_zone = "${element(var.availability_zone, count.index)}"
  subnet_id = "${element(var.db_subnet, count.index)}"
  key_name  = "${element(var.key, 1)}"

  root_block_device {
    volume_size = var.ebs_size
    volume_type = var.ebs_type
    tags = {
      "Name" = "${var.env}-db-volume-${count.index+1}"
    }
  }

  tags = {
    "Name" = "${var.env}-db-${count.index+1}"
  }
}

# db instances
resource "aws_instance" "tf-web" {
  count         = "${length(var.availability_zone)}"
  ami           = data.aws_ami.tf-ami.id
  instance_type = var.instance_type
  vpc_security_group_ids = [var.web_sg]

  availability_zone = "${element(var.availability_zone, count.index)}"
  subnet_id = "${element(var.web_subnet, count.index)}"
  key_name  = "${element(var.key, 1)}"

  root_block_device {
    volume_size = var.ebs_size
    volume_type = var.ebs_type
    tags = {
      "Name" = "${var.env}-web-volume-${count.index+1}"
    }
  }

  tags = {
    "Name" = "${var.env}-web-${count.index+1}"
  }
}
