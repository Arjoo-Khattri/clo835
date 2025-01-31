# Provider
provider "aws" {
  region = "us-east-1"
}

# Local variables
locals {
  default_tags = merge( var.default_tags, { "Env" = var.dev })
  name_prefix = "${var.prefix}-${var.dev}"
}

# Create a new VPC 
resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = merge(
    local.default_tags, {
      Name = "${local.name_prefix}-vpc"
    }
  )
}

# Public Subnets in the VPC
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_cidr_blocks # Ensure you define 2 CIDR blocks in variables
  }

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(local.default_tags,
    {
      Name = "${local.name_prefix}-igw"
    }
  )
}



# Public Route Table for Public Subnets
resource "aws_route_table" "public_route_table" {
vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(
    local.default_tags,
    { Name = "${local.name_prefix}-public-route-table" }
  )
}

# Associate public subnets with the public route table
resource "aws_route_table_association" "public_route_table_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id      = aws_subnet.public_subnet.id
}