# variables.tf
variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for data lake"
  type        = string
}

variable "redshift_cluster_identifier" {
  description = "Redshift cluster identifier"
  type        = string
}

variable "redshift_database_name" {
  description = "Redshift database name"
  type        = string
}

variable "redshift_master_username" {
  description = "Redshift master username"
  type        = string
}

variable "redshift_master_password" {
  description = "Redshift master password"
  type        = string
}

variable "redshift_iam_role_name" {
  description = "Redshift IAM role name"
  type        = string
}

variable "redshift_subnet_group_name" {
  description = "Redshift subnet group name"
  type        = string
}

variable "key_pair_name" {
  description = "Name of the existing EC2 key pair"
  type        = string
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

variable "airflow_version" {
  description = "Version of Airflow to install"
  type        = string
  default     = "2.2.3"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
