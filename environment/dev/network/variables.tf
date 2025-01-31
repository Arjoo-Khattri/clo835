# Default tags
variable "default_tags" {
  default = {
    "Owner" = "Arjoo",
    "App"   = "Web"
  }
  type        = map(any)
  description = "Default tags to be appliad to all AWS resources"
}

# Name prefix
variable "prefix" {
  type        = string
  default     = ""
  description = "Name prefix"
}

#  vpc
variable "vpc_cidr" {
  description = "CIDR block for the non-prod VPC."
  type        = string
  default     = "10.1.0.0/16"
}

#  Public Subnet
variable "public_subnet_cidrs" {
  description = "CIDR block for the non-prod public subnet."
  type        = string
  default     = "10.1.1.0/24"
}

# Variable to signal the current environment 
variable "dev" {
  default     = "dev"
  type        = string
  description = "Deployment Environment"
}

variable "public_rt" {
  type = bool
  default = true
}
