output "vpc_cidr" {
value = aws_vpc.main.cidr_block 
  
}

output "public_subnet_ids" {
  value = module.dev_vpc.public_subnet_ids
}

