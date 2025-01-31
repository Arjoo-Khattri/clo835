variable "dev" {
  default = "dev"
  description = "The environment for the deployment"
  type        = string
}

variable "instance_type" {
  description = "A map of instance types based on environment"
  type        = string
  default     =  "t2.micro"
}

variable "default_tags" {
  description = "Tags to apply to all resources"
  type        = string
  default     = "assignment1" 
}

variable "prefix" {
  description = "A prefix for resource names"
  type        = string
  default = "dev"
}