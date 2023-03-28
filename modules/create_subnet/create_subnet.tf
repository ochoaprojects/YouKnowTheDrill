# Create two subnets within the VPC
resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "example-subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "example-subnet2"
  }
}
