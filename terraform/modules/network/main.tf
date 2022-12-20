resource "aws_vpc" "tf-vpc" {
  cidr_block       = "${var.cidr_block}"
#   instance_tenancy = "default"

  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_internet_gateway" "tf-igw" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "${var.env}-igw"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

# public subnet 2
resource "aws_subnet" "public-subnet" {
  count = "${length(var.availability_zone)}"
  vpc_id = aws_vpc.tf-vpc.id
  availability_zone = "${element(var.availability_zone, count.index)}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, count.index)}"
  tags = { 
    Name = "pub-subnet${count.index}"
  }
}