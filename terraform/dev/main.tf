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
    user_name = module.iam.iam_user
    cidr_block = var.vpc_cidr_block
    availability_zone = var.azs
}

module "sg" {
    source = "../modules/sg"
    vpc_id = module.network.vpc_id
}

module "key" {
    source = "../modules/key"
    key_div = var.div
}

module "ec2" {
    source = "../modules/ec2"
    env = var.env
    availability_zone = module.network.availability_zone
    instance_type = var.instance_type
    key = var.key
    ebs_size = var.size
    ebs_type = var.type

    bastion_sg = module.sg.bastion_sg_id
    bastion_subnet = module.network.public_subnet_id

    web_sg = module.sg.web_sg_id
    web_subnet = module.network.web_subnet_id

    was_sg = module.sg.was_sg_id
    was_subnet = module.network.was_subnet_id

    db_sg = module.sg.db_sg_id
    db_subnet = module.network.rds_subnet_id
}

