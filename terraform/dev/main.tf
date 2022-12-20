module "iam" {
    source = "../modules/iam"
    env = var.env
    user_name = var.user_alias
    group_name = var.group_alias
}

module "network" {
  source =  "../modules/network"
  env = var.env
  vpc_cidr = var.vpc_cidr_block
  user_name = var.user_alias
  cidr_block = var.vpc_cidr_block
  availability_zone = var.azs
}