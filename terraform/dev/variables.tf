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

