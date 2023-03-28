resource "aws_vpc" "vpc_egress" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "vpc_egress"
  }
}

resource "aws_subnet" "subnet_egress_public_az1" {
  vpc_id                  = aws_vpc.vpc_egress.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_egress_public_az1"
  }
}

resource "aws_subnet" "subnet_egress_public_az2" {
  vpc_id                  = aws_vpc.vpc_egress.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_egress_public_az2"
  }
}

resource "aws_subnet" "subnet_egress_private_az1" {
  vpc_id     = aws_vpc.vpc_egress.id
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "subnet_egress_private_az1"
  }
}

resource "aws_subnet" "subnet_egress_private_az2" {
  vpc_id     = aws_vpc.vpc_egress.id
  cidr_block = "10.0.4.0/24"
  tags = {
    Name = "subnet_egress_private_az2"
  }
}

resource "aws_internet_gateway" "igw_egress" {
  vpc_id = aws_vpc.vpc_egress.id
  tags = {
    Name = "igw_egress"
  }
}

resource "aws_route_table" "rt_egress_public_az1" {
  vpc_id = aws_vpc.vpc_egress.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_egress.id
  }
  tags = {
    Name = "rt_egress_public_az1"
  }
}

resource "aws_route_table" "rt_egress_public_az2" {
  vpc_id = aws_vpc.vpc_egress.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_egress.id
  }
  tags = {
    Name = "rt_egress_public_az2"
  }
}

resource "aws_route_table" "rt_egress_private_az1" {
  vpc_id = aws_vpc.vpc_egress.id
  tags = {
    Name = "rt_egress_private_az1"
  }
}

resource "aws_route_table" "rt_egress_private_az2" {
  vpc_id = aws_vpc.vpc_egress.id
  tags = {
    Name = "rt_egress_private_az2"
  }
}

resource "aws_route_table_association" "rt_association_egress_public_az1" {
  subnet_id      = aws_subnet.subnet_egress_public_az1.id
  route_table_id = aws_route_table.rt_egress_public_az1.id
}

resource "aws_route_table_association" "rt_association_egress_public_az2" {
  subnet_id      = aws_subnet.subnet_egress_public_az2.id
  route_table_id = aws_route_table.rt_egress_public_az2.id
}

resource "aws_route_table_association" "rt_association_egress_private_az1" {
  subnet_id      = aws_subnet.subnet_egress_private_az1.id
  route_table_id = aws_route_table.rt_egress_private_az1.id
}

resource "aws_route_table_association" "rt_association_egress_private_az2" {
  subnet_id      = aws_subnet.subnet_egress_private_az2.id
  route_table_id = aws_route_table.rt_egress_private_az2.id
}
