variable "dev" {
  description = "The environment for the deployment"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_cidr_blocks" {
  description = "List of public CIDR blocks for subnets"
  type        = string
}

variable "default_tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

variable "prefix" {
  description = "A prefix for resource names"
  type        = string
}

variable "public_rt" {
  type = bool
  default = false
}

