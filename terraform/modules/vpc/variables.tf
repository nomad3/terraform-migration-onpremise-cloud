# VPC module variables.tf
variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_block" {
  type        = string
  default     = "10.0.1.0/24"
  description = "CIDR block for public subnets"
}

variable "private_subnet_cidr_block" {
  type        = string
  default     = "10.0.2.0/24"
  description = "CIDR block for private subnets"
}

variable "azs" {
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
  description = "List of availability zones"
}

variable "vpc_name" {
  type        = string
  default     = "MainVPC"
  description = "Name of the VPC"
}
