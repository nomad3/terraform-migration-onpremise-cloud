# main.tf
terraform {
  required_version = ">= 0.13"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Include modules
module "vpc" {
  source = "./modules/vpc"
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.s3_bucket_name
  tags        = var.tags
}

module "redshift" {
  source               = "./modules/redshift"
  private_subnet_ids   = module.vpc.private_subnets
  security_group_ids   = [module.vpc.default_security_group_id]
  cluster_identifier   = var.redshift_cluster_identifier
  database_name        = var.redshift_database_name
  master_username      = var.redshift_master_username
  master_password      = var.redshift_master_password
  iam_role_name        = var.redshift_iam_role_name
  subnet_group_name    = var.redshift_subnet_group_name
  tags                 = var.tags
}

module "airflow" {
  source             = "./modules/airflow"
  vpc_id             = module.vpc.vpc_id
  public_subnet_id   = module.vpc.public_subnets[0]
  key_pair_name      = var.key_pair_name
  allowed_ssh_cidr   = var.allowed_ssh_cidr
  allowed_http_cidr  = var.allowed_http_cidr
  airflow_version    = var.airflow_version
  aws_region         = var.aws_region
  tags               = var.tags
}

# Outputs
output "redshift_endpoint" {
  value = module.redshift.redshift_endpoint
}

output "s3_bucket_name" {
  value = module.s3.bucket_name
}

output "airflow_public_ip" {
  value = module.airflow.airflow_public_ip
}
