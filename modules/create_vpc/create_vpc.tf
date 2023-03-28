resource "aws_vpc" "VPC_A" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC-A"
  }
}

resource "aws_vpc" "VPC_B" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "VPC-B"
  }
}

resource "aws_vpc" "VPC_C" {
  cidr_block = "10.2.0.0/16"
  tags = {
    Name = "VPC-C"
  }
}
