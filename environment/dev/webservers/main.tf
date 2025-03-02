# Provider
provider "aws" {
  region = "us-east-1"
}

# Data source for AMI id
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Remote state to retrieve the data
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "clo835-assignment2-arjoo"      // Bucket from where to GET Terraform State
    key    = "dev/network/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                     // Region where bucket created
  }
}

# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

# Define tags locally
locals {
  default_tags = merge(module.globalvars.default_tags, { "dev" = var.dev })
  prefix = module.globalvars.prefix
  name_prefix  = "${local.prefix}-${var.dev}"
}

# Retrieve global variables from the Terraform module
module "globalvars" {
  source = "../../../modules/globalvars"
}

# Create EC2 key pair
resource "aws_key_pair" "ec2_key" {
  key_name   = "assignment2"
  public_key = file("./assignment2.pub")
}

# EC2 instance configuration
resource "aws_instance" "public_ec2" {
  ami                       = data.aws_ami.latest_amazon_linux.id
  instance_type             = var.instance_type
  subnet_id                 = data.terraform_remote_state.network.outputs.public_subnet_ids[0]
  vpc_security_group_ids    = [aws_security_group.web_sg.id] # Use the first public subnet
  associate_public_ip_address = true
  key_name                   = aws_key_pair.ec2_key.key_name

  tags = { Name = "public_instance" }
}

# Security Group for WebApp and MySQL on EC2
resource "aws_security_group" "web_sg" {
  name        = "allow_http_ssh_mysql_webapp"
  description = "Allow HTTP, SSH, MySQL, and WebApp NodePort access"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_cidr


  # Allow HTTP (80) for web traffic
  ingress {
    description = "Allow HTTP traffic from everywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow SSH (22) for remote access
  ingress {
    description = "Allow SSH access from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow WebApp access via NodePort (30000)
  ingress {
    description = "Allow WebApp external access via NodePort"
    from_port   = 30000
    to_port     = 30000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow MySQL (3306) for database access (WebApp -> MySQL)
  ingress {
    description = "Allow MySQL access from within the VPC"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Ensure this is a CIDR block, not a VPC ID.
  }

  # Allow outbound traffic to any destination
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags, {
    "Name" = "${local.name_prefix}-sg"
  })
}
