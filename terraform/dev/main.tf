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

# module "db" {
#     source = "../modules/db"
#     env = var.env
#     availability_zone = module.network.availability_zone
#     db_identifier = var.database_name
#     db_subnet_ids = module.network.rds_subnet_id

#     db_storage_size = var.storage_size
#     db_engine = var.engine
#     db_engine_version = var.engine_version
#     instance_class = var.class
#     db_user = var.db_username
#     db_passwd = var.db_password
#     boolOption = var.bool
#     family = var.family
#     subnet_name = var.subnet_group_name
#     param_name = var.param_group_name
#     option_name = var.option_group_name
#     security_group_id = module.sg.db_sg_id
# }

module "lb" {
    source = "../modules/lb"
    env = var.env
    vpc_id = module.network.vpc_id
    ex_sg_id = module.sg.exlb_sg_id
    ex_subnet_ids = module.network.public_subnet_id
    ex_target_instance = module.ec2.web_instance_id
    in_sg_id = module.sg.inlb_sg_id
    in_subnet_ids = module.network.was_subnet_id
}
