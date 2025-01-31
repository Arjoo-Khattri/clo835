
module "dev_vpc" {
  source              = "../../../modules/aws_network"
  dev                 = var.dev
  vpc_cidr            = var.vpc_cidr
  public_cidr_blocks  = var.public_subnet_cidrs
  prefix              = var.prefix
  default_tags        = var.default_tags
  public_rt           = true
}