output "vpc_cidr" {
value = module.dev_vpc.vpc_id  
}

output "public_subnet_ids" {
  value = module.dev_vpc.public_subnet_ids
}

