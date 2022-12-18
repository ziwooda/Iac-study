module "iam" {
    source = "../modules/iam"
    env = var.env
    user_name = var.user_alias
    group_name = var.group_alias
}