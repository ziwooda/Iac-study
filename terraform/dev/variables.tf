variable "env" {
  type = string
  description = "dev"
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
  description = "availability zone in Seoul"
  type = list
  # default = ["ap-northeast-2a", "ap-northeast-2c"]
}

