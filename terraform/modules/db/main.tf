resource "aws_db_subnet_group" "rds-subnet" {
  name       = var.subnet_name
  description = "rds subnet group for mariadb database"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "rds-subnet"
  }
}

resource "aws_db_option_group" "rds-option" {
  name                     = var.option_name
  option_group_description = "rds option group for mariadb database"
  engine_name              = var.db_engine
  major_engine_version     = var.db_engine_version
}

resource "aws_db_parameter_group" "rds-param" {
  name   = var.param_name
  family = var.family

  parameter {
    name  = "time_zone"
    value = "Asia/Seoul"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_filesystem"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "collation_connection"
    value = "utf8mb4_general_ci"
  }

  parameter {
    name  = "collation_server"
    value = "utf8mb4_general_ci"
  }

  parameter {
    name  = "max_connections"
    value = "150"
  }

  lifecycle { create_before_destroy = true }
}

resource "aws_db_instance" "tf-db" {
  allocated_storage    = var.db_storage_size
  max_allocated_storage = var.db_storage_size * 3
  identifier           = "${var.env}-rds"
  db_name              = var.db_identifier
  engine               = var.db_engine
  engine_version       = var.db_engine_version
  instance_class       = var.instance_class
  username             = var.db_user
  password             = var.db_passwd
  availability_zone = "${element(var.availability_zone, 0)}"
  db_subnet_group_name = aws_db_subnet_group.rds-subnet.name
  parameter_group_name = aws_db_parameter_group.rds-param.name
  option_group_name = aws_db_option_group.rds-option.name
  vpc_security_group_ids = [var.security_group_id]
  apply_immediately = "${element(var.boolOption, 0)}"
  skip_final_snapshot  = "${element(var.boolOption, 0)}"
  multi_az = "${element(var.boolOption, 0)}"
  backup_retention_period = "7"
}
