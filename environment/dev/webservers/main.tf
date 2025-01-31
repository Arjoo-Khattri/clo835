# ACS730 - Assignment 1 

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
    bucket = "clo835-assignment1-arjoo"      // Bucket from where to GET Terraform State
    key    = "dev/network/terraform.tfstate" // Object name in the bucket to GET Terraform State
    region = "us-east-1"                             // Region where bucket created
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

resource "aws_key_pair" "ec2_key" {
  key_name   = "assignment1"
  public_key = file("./assignment1.pub")
}

resource "aws_instance" "public_ec2" {
  ami                       = data.aws_ami.latest_amazon_linux.id
  instance_type             = var.instance_type
  subnet_id                 = data.terraform_remote_state.network.outputs.public_subnet_ids[0] 
  vpc_security_group_ids = [aws_security_group.web_sg.id] # Use the first public subnet
  associate_public_ip_address = true
  key_name                   = aws_key_pair.ec2_key.key_name

  tags = {Name = "public_instance"}
  
}


# Security Group
resource "aws_security_group" "web_sg" {
  name        = "allow_http_ssh"
  description = "Allow HTTP and SSH inbound traffic"
  vpc_id      = data.terraform_remote_state.network.outputs.vpc_cidr

  ingress {
    description      = "HTTP from everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "SSH from everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-sg"
    }
  )
}