resource "aws_vpc" "tf-vpc" {
  cidr_block       = "${var.cidr_block}"
#   instance_tenancy = "default"

  tags = {
    Name = "${var.env}-vpc"
  }
}

# public subnet
resource "aws_subnet" "public_subnet" {
  count = "${length(var.availability_zone)}"
  vpc_id = aws_vpc.tf-vpc.id
  availability_zone = "${element(var.availability_zone, count.index)}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, count.index+1)}"
  tags = { 
    Name = "pub-subnet${count.index+1}"
  }
}

# web private subnet
resource "aws_subnet" "web_subnet" {
  count = "${length(var.availability_zone)}"
  vpc_id = aws_vpc.tf-vpc.id
  availability_zone = "${element(var.availability_zone, count.index)}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, count.index+11)}"
  tags = { 
    Name = "pri-subnet${count.index+1}"
  }
}

# was private subnet
resource "aws_subnet" "was_subnet" {
  count = "${length(var.availability_zone)}"
  vpc_id = aws_vpc.tf-vpc.id
  availability_zone = "${element(var.availability_zone, count.index)}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, count.index+21)}"
  tags = { 
    Name = "pri-subnet${count.index+3}"
  }
}

# rds private subnet
resource "aws_subnet" "rds_subnet" {
  count = "${length(var.availability_zone)}"
  vpc_id = aws_vpc.tf-vpc.id
  availability_zone = "${element(var.availability_zone, count.index)}"
  cidr_block = "${cidrsubnet(var.vpc_cidr, 8, count.index+31)}"
  tags = { 
    Name = "pri-subnet${count.index+5}"
  }
}

# internet gateway
resource "aws_internet_gateway" "tf-igw" {
  vpc_id = aws_vpc.tf-vpc.id

  tags = {
    Name = "${var.env}-igw"
  }
}

# eip for ngw
resource "aws_eip" "tf-eip" {
  vpc      = true
  depends_on = [
    aws_internet_gateway.tf-igw
  ]

  tags = {
    Name = "${var.env}-eip"
  }
}

# nat gateway
resource "aws_nat_gateway" "tf-nat" {
  allocation_id = aws_eip.tf-eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "${var.env}-nat"
  }

  depends_on = [aws_internet_gateway.tf-igw]
}

# route table & association
resource "aws_route_table" "tf-pub-rt" {
  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-igw.id
  }

  tags = {
    Name = "pub-rt"
  }
}

resource "aws_route_table" "tf-pri-rt" {
  vpc_id = aws_vpc.tf-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.tf-nat.id
  }

  tags = {
    Name = "pri-rt"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.availability_zone)
  subnet_id = "${element(aws_subnet.public_subnet.*.id, count.index)}"
  route_table_id = aws_route_table.tf-pub-rt.id
}

resource "aws_route_table_association" "web_private" {
  count = "${length(var.availability_zone)}"
  subnet_id = "${element(aws_subnet.web_subnet.*.id, count.index)}"
  route_table_id = aws_route_table.tf-pri-rt.id
}

resource "aws_route_table_association" "was_private" {
  count = "${length(var.availability_zone)}"
  subnet_id = "${element(aws_subnet.was_subnet.*.id, count.index)}"
  route_table_id = aws_route_table.tf-pri-rt.id
}

resource "aws_route_table_association" "rds_private" {
  count = "${length(var.availability_zone)}"
  subnet_id = "${element(aws_subnet.rds_subnet.*.id, count.index)}"
  route_table_id = aws_route_table.tf-pri-rt.id
}
