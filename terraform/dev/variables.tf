variable "env" {
  type        = string
  description = "dev"
}

variable "remote_state_backend" {
  type        = string
  description = "s3 bucket name for remote state"
}

variable "backend_key" {
  type        = string
  description = "backend key"
}

variable "div" {
  type        = list(any)
  description = "key division"
}

variable "user_alias" {
  type        = string
  description = "iam_user_name"
}

variable "group_alias" {
  type        = string
  description = "iam_group_name"
}

variable "vpc_cidr_block" {
  type        = string
  description = "vpc_cidr_block"
}

variable "azs" {
  type        = list(any)
  description = "availability zone in Seoul"
}

variable "instance_type" {
  type        = string
  description = "instance type of ec2"
}

variable "key" {
  type        = list(any)
  description = "key for instances"
}

variable "size" {
  type        = number
  description = "ebs size"
}

variable "type" {
  type        = string
  description = "ebs type"
}

# variable "nginx_user_data" {
#   type = string
#   description = "user data for nginx"
# }

variable "database_name" {
  type        = string
  description = "database name/identifier"
}

variable "storage_size" {
  type        = number
  description = "allocated storage size of db instance"
}

variable "engine" {
  type        = string
  description = "name of db engine"
}

variable "engine_version" {
  type        = string
  description = "version of db engine"
}

variable "class" {
  type        = string
  description = "db instance class"
}

variable "db_username" {
  type        = string
  description = "username of database"
}

variable "db_password" {
  type        = string
  description = "password of database"
}

variable "bool" {
  type        = list(any)
  description = "boolean value of database options"
}

variable "family" {
  type        = string
  description = "family name of db param group"
}

variable "subnet_group_name" {
  type        = string
  description = "subnet group name for database"
}

variable "param_group_name" {
  type        = string
  description = "param group name for database"
}

variable "option_group_name" {
  type        = string
  description = "option group name for database"
}