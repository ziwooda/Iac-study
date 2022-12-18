module "iam" {
    source = "../modules/iam"
    user_name = var.user_alias
    group_name = var.group_alias
}