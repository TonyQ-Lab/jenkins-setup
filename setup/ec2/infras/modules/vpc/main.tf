
# Create a vpc
resource "aws_vpc" "jenkins-vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

# Create 2 public subnets
resource "aws_subnet" "jenkins" {
  vpc_id                  = aws_vpc.jenkins-vpc.id
  cidr_block              = var.vpc_subnet["cidr_block"]
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = var.vpc_subnet["name"]
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "jenkins-igw" {
  vpc_id = aws_vpc.jenkins-vpc.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# Create a route table for the public subnets
resource "aws_route_table" "jenkins-public-rtb" {
  vpc_id = aws_vpc.jenkins-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.jenkins-igw.id
  }
}

# Create a route table association for each public subnet
resource "aws_route_table_association" "jenkins-public-rtb-assoc" {
  subnet_id      = aws_subnet.jenkins.id
  route_table_id = aws_route_table.jenkins-public-rtb.id
}

# Create a security group for the public subnets
resource "aws_security_group" "jenkins-public-sg" {
  vpc_id      = aws_vpc.jenkins-vpc.id
  name        = "${var.vpc_name}-public-sg"
  description = "Security group for public subnets"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}