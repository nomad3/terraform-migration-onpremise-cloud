variable "cluster_identifier" {
  description = "Redshift cluster identifier"
  type        = string
}

variable "node_type" {
  description = "Redshift node type"
  type        = string
  default     = "dc2.large"
}

variable "number_of_nodes" {
  description = "Number of nodes in the cluster"
  type        = number
  default     = 2
}

variable "database_name" {
  description = "Name of the first database to be created when the cluster is created"
  type        = string
}

variable "master_username" {
  description = "Username for the master DB user"
  type        = string
}

variable "master_password" {
  description = "Password for the master DB user"
  type        = string
}

variable "iam_role_name" {
  description = "Name of the IAM role for Redshift"
  type        = string
}

variable "subnet_group_name" {
  description = "Name of the Redshift subnet group"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
