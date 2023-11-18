# CONFIGURE AWS PROVIDER
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-east-1"
  #profile = "Admin"
}
# CREATE VPC
resource "aws_vpc" "eksvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  tags = {
    Name = "eksvpc"
  }
}
# CREATE SUBNETS
resource "aws_subnet" "publicsubnet1" {
  vpc_id     = aws_vpc.eksvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "publicsubnet1"
  }
}
resource "aws_subnet" "privatesubnet1" {
  vpc_id     = aws_vpc.eksvpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "privatesubnet1"
  }
}
resource "aws_subnet" "publicsubnet2" {
  vpc_id     = aws_vpc.eksvpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "publicsubnet2"
  }
}
resource "aws_subnet" "privatesubnet2" {
  vpc_id     = aws_vpc.eksvpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name =  "privatesubnet2"
  }
}
# CREATE INTERNET GATEWAY
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.eksvpc.id
  tags = {
    Name = "eksig"
  }
}
# CONFIGURE A NAT GATEWAY
resource "aws_eip" "elastic-ip" {
  domain = "vpc"
}
resource "aws_nat_gateway" "ngw" {
  subnet_id     = aws_subnet.publicsubnet1.id
  allocation_id = aws_eip.elastic-ip.id
}
# CONFIGURE ROUTE TABLES
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.eksvpc.id
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.eksvpc.id
}
# CONFIGURE ROUTES
resource "aws_route" "private_ngw" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
}
resource "aws_route_table_association" "public_1_subnet" {
  subnet_id      = aws_subnet.publicsubnet1.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "private_1_subnet" {
  subnet_id      = aws_subnet.privatesubnet1.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route_table_association" "public_2_subnet" {
  subnet_id      = aws_subnet.publicsubnet2.id
  route_table_id = aws_route_table.public.id
}
resource "aws_route_table_association" "private_2_subnet" {
  subnet_id      = aws_subnet.privatesubnet2.id
  route_table_id = aws_route_table.private.id
}
resource "aws_route" "public_igw" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}