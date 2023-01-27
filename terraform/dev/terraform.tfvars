env = "dev"

# iam
user_alias = "ziwoo"
group_alias = "Terraform"

# vpc
vpc_cidr_block = "10.0.0.0/16"
azs = ["ap-northeast-2a", "ap-northeast-2c"]

# key
div = ["public", "private"]

# ec2
instance_type = "t2.micro"
key = ["tf-public-key", "tf-private-key"]
size = 50
type = "gp2"
# nginx_user_data = "/Users/ziwoo/Documents/GitHub/Iac-study/terraform/modules/ec2/nginx.sh"

# db
storage_size = 20
database_name = "tf_database"
engine = "mariadb"
engine_version = "10.6"
class = "db.t3.micro"
db_username = "admin"
db_password = "ziwoo99!!"
bool = [true, false]
family = "mariadb10.6"
subnet_group_name = "rds-subnet"
param_group_name = "rds-param"
option_group_name = "rds-option"
