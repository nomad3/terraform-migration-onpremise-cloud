variable "name" {
  description = "Name identifier for resources"
  type        = string
  default     = "airflow"
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID"
  type        = string
}

variable "key_pair_name" {
  description = "Name of the existing EC2 key pair"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for Airflow"
  type        = string
  default     = "t3.medium"
}

variable "airflow_version" {
  description = "Version of Airflow to install"
  type        = string
  default     = "2.2.3"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to access SSH"
  type        = string
  default     = "0.0.0.0/0"
}

variable "allowed_http_cidr" {
  description = "CIDR block allowed to access Airflow UI"
  type        = string
  default     = "0.0.0.0/0"
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
