resource "aws_vpc" "vpc_internal" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "vpc_internal"
  }
}

resource "aws_subnet" "subnet_internal_private_az1" {
  vpc_id                  = aws_vpc.vpc_internal.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_internal_private_az1"
  }
}

resource "aws_subnet" "subnet_internal_private_az2" {
  vpc_id                  = aws_vpc.vpc_internal.id
  cidr_block              = "10.1.2.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet_internal_private_az2"
  }
}

resource "aws_vpc_peering_connection" "pcx_internal_to_egress" {
  peer_vpc_id = aws_vpc.vpc_egress.id
  vpc_id      = aws_vpc.vpc_internal.id
  auto_accept = true
  tags = {
    Name = "pcx_internal_to_egress"
  }
}

resource "aws_route_table" "rt_internal_private_az1" {
  vpc_id = aws_vpc.vpc_internal.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_vpc_peering_connection.pcx_internal_to_egress.id
  }
  tags = {
    Name = "rt_internal_private_az1"
  }
}

resource "aws_route_table" "rt_internal_private_az2" {
  vpc_id = aws_vpc.vpc_internal.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_vpc_peering_connection.pcx_internal_to_egress.id
  }
  tags = {
    Name = "rt_internal_private_az2"
  }
}

resource "aws_route_table_association" "rt_association_internal_private_az1" {
  subnet_id      = aws_subnet.subnet_internal_private_az1.id
  route_table_id = aws_route_table.rt_internal_private_az1.id
}

resource "aws_route_table_association" "rt_association_internal_private_az2" {
  subnet_id      = aws_subnet.subnet_internal_private_az2.id
  route_table_id = aws_route_table.rt_internal_private_az2.id
}
