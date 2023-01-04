variable "env" {
  type = string
  description = "dev"
}

variable "div" {
  type = list
  description = "key division"
}

variable "user_alias" {
  type = string
  description = "iam_user_name"
}

variable "group_alias" {
  type = string
  description = "iam_group_name"
}

variable "vpc_cidr_block" {
  type = string
  description = "vpc_cidr_block"
}

variable "azs" {
  type = list
  description = "availability zone in Seoul"
}

variable "instance_type" {
  type = string
  description = "instance type of ec2"
}

variable "key" {
  type = list
  description = "key for instances"
}

variable "size" {
  type = number
  description = "ebs size"
}

variable "type" {
  type = string
  description = "ebs type"
}

variable "database_name" {
  type = string
  description = "database name/identifier"
}

variable "storage_size" {
  type = number
  description = "allocated storage size of db instance"
}

variable "engine" {
  type = string
  description = "name of db engine"
}

variable "engine_version" {
  type = string
  description = "version of db engine"
}

variable "class" {
  type = string
  description = "db instance class"
}

variable "db_username" {
  type = string
  description = "username of database"
}

variable "db_password" {
  type = string
  description = "password of database"
}

variable "bool" {
  type = list
  description = "boolean value of database options"  
}

variable "family" {
  type = string
  description = "family name of db param group"
}

variable "subnet_group_name" {
  type = string
  description = "subnet group name for database"
}

variable "param_group_name" {
  type = string
  description = "param group name for database"
}

variable "option_group_name" {
  type = string
  description = "option group name for database"
}