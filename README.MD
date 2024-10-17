# README.md

## **Challenge: Migrating Legacy On-Premises Data Warehouse to AWS Cloud**

This repository contains the code and resources for migrating a legacy on-premises data warehouse to a modern cloud data platform on AWS. The solution handles structured, semi-structured, and unstructured data, providing capabilities for data engineering and data science teams. The infrastructure is managed using Terraform, with Docker used to simulate on-premises databases for development and testing.

---

## **Table of Contents**

- [Challenge Description](#challenge-description)
- [Repository Structure](#repository-structure)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
  - [1. Clone the Repository](#1-clone-the-repository)
  - [2. Configure AWS Credentials](#2-configure-aws-credentials)
  - [3. Initialize and Run Docker Containers](#3-initialize-and-run-docker-containers)
  - [4. Initialize and Apply Terraform Infrastructure](#4-initialize-and-apply-terraform-infrastructure)
- [Testing](#testing)
  - [Running Terratest](#running-terratest)
- [Deployment to Production](#deployment-to-production)
- [Cleanup](#cleanup)
- [Notes and Considerations](#notes-and-considerations)
- [Contact Information](#contact-information)

---

## **Challenge Description**

The challenge involves migrating a legacy on-premises data warehouse (e.g., Oracle, SQL Server, Hadoop) to a modern cloud data warehouse or data lake solution on AWS. The solution must:

- Handle structured, semi-structured, and unstructured data from disparate source systems.
- Equip data engineering and data science teams with access to this data.
- Use Infrastructure as Code (IaC) with Terraform.
- Implement deployment automation.
- Include data validation and testing strategies.
- Follow best practices for security, scalability, and maintainability.

---

## **Repository Structure**

```plaintext
├── terraform/
│   ├── modules/
│   │   ├── vpc/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   ├── s3/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   ├── redshift/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   │   ├── airflow/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   ├── outputs.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── versions.tf
├── docker/
│   ├── docker-compose.yml
│   ├── oracle/
│   │   ├── Dockerfile
│   │   ├── oracle-xe.conf
│   │   ├── startup.sh
│   ├── mssql/
│   │   ├── Dockerfile
│   │   ├── init.sql
├── airflow_dags/
│   └── data_migration_dag.py
├── tests/
│   └── test_infra.go
├── .github/
│   └── workflows/
│       └── ci_cd_pipeline.yml
├── README.md
```

### **Main Components**

- **terraform/**: Contains Terraform configurations for provisioning AWS infrastructure.
  - **modules/**: Reusable Terraform modules for VPC, S3, Redshift, and Airflow.
    - **vpc/**: Defines the Virtual Private Cloud networking components.
    - **s3/**: Provisions an S3 bucket for the data lake.
    - **redshift/**: Sets up an Amazon Redshift cluster.
    - **airflow/**: Deploys an EC2 instance with Apache Airflow installed.
  - **main.tf**: Entry point for Terraform; calls modules and passes variables.
  - **variables.tf**: Defines input variables for Terraform.
  - **outputs.tf**: Exports outputs from Terraform.
  - **provider.tf**: Configures the AWS provider.
  - **versions.tf**: Specifies Terraform and provider versions.
- **docker/**: Contains Docker configurations to simulate on-premises databases.
  - **docker-compose.yml**: Defines the Docker services.
  - **oracle/**: Dockerfile and configurations for Oracle XE database.
  - **mssql/**: Dockerfile and configurations for SQL Server database.
- **airflow_dags/**: Airflow DAGs for orchestrating data migration and processing.
- **tests/**: Contains Terratest scripts for testing the infrastructure.
- **.github/**: GitHub Actions workflows for CI/CD pipeline.
- **README.md**: Documentation and instructions.

---

## **Prerequisites**

- **AWS Account**: Access to an AWS account with permissions to create resources.
- **AWS CLI**: Installed and configured with your AWS credentials.
- **Terraform**: Version 0.13 or higher installed.
- **Docker and Docker Compose**: Installed for simulating on-premises databases.
- **Go Programming Language**: Installed for running Terratest.
- **Git**: Installed for cloning the repository.
- **SSH Key Pair**: An existing AWS EC2 key pair for accessing the Airflow EC2 instance.

---

## **Setup Instructions**

### **1. Clone the Repository**

```bash
git clone https://github.com/your_username/your_repository.git
cd your_repository
```

### **2. Configure AWS Credentials**

Ensure your AWS credentials are configured. You can set them using environment variables or AWS CLI configuration:

```bash
aws configure
```

### **3. Initialize and Run Docker Containers**

Navigate to the `docker/` directory and start the Docker containers to simulate on-premises databases.

```bash
cd docker
docker-compose up -d
```

- **Note**: You may need to download the Oracle XE installation files manually due to licensing restrictions. Place the required files in the `docker/oracle/` directory.

### **4. Initialize and Apply Terraform Infrastructure**

#### **a. Navigate to the Terraform Directory**

```bash
cd ../terraform
```

#### **b. Initialize Terraform**

```bash
terraform init
```

#### **c. Review and Edit Variables**

Review the `variables.tf` file and ensure all required variables are set. You can create a `terraform.tfvars` file to set variable values:

```hcl
aws_region        = "us-west-2"
s3_bucket_name    = "my-data-lake-bucket-unique-id"
redshift_master_user = "adminuser"
redshift_master_pass = "YourSecurePassword123!"
key_pair_name     = "your-ec2-key-pair-name"
```

- **Important**: Replace the variable values with your own configurations.

#### **d. Validate the Terraform Configuration**

```bash
terraform validate
```

#### **e. Plan the Terraform Deployment**

```bash
terraform plan
```

Review the plan output to ensure resources will be created as expected.

#### **f. Apply the Terraform Configuration**

```bash
terraform apply
```

Type `yes` when prompted to confirm the deployment.

---

## **Testing**

### **Running Terratest**

Navigate to the `tests/` directory and run the Terratest script:

```bash
cd ../tests
go test -v -timeout 30m
```

- **Note**: Ensure you have Go installed and the necessary Go modules are available.
- **Terratest** validates the infrastructure by checking resources are created correctly.

---

## **Deployment to Production**

In a production environment, deployments should be automated and managed via a CI/CD pipeline. This repository includes a GitHub Actions workflow for automating testing and deployment.

### **Using GitHub Actions CI/CD Pipeline**

1. **Configure AWS Credentials in GitHub**

   - Set up AWS access keys as secrets in your GitHub repository settings (`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`).

2. **Review the Workflow Configuration**

   - The workflow file is located at `.github/workflows/ci_cd_pipeline.yml`.
   - It automates formatting checks, validation, Terratest execution, and linting.

3. **Trigger the Pipeline**

   - The pipeline runs automatically on pushes to the `main` branch or when a pull request is opened.
   - Ensure your code changes are committed and pushed to GitHub.

```bash
git add .
git commit -m "Your commit message"
git push origin main
```

4. **Monitor the Pipeline**

   - Check the Actions tab in your GitHub repository to monitor the pipeline execution.
   - Ensure all steps pass before considering the deployment successful.

---

## **Cleanup**

To avoid incurring charges on your AWS account, destroy the infrastructure when it's no longer needed.

```bash
cd ../terraform
terraform destroy
```

Type `yes` when prompted to confirm the destruction.

---

## **Notes and Considerations**

- **Sensitive Data**: Do not hard-code sensitive information (passwords, secrets) in your code. Use AWS Secrets Manager or environment variables to manage secrets securely.
- **Licensing**: Ensure compliance with all software licensing agreements, especially for Oracle software.
- **Resource Limits**: Adjust instance types and resource configurations according to your needs and AWS service limits.
- **Security**: Restrict SSH and HTTP access to trusted IP ranges by modifying `allowed_ssh_cidr` and `allowed_http_cidr` variables.
- **Production Readiness**:
  - For production, consider using managed services like AWS Managed Workflows for Apache Airflow (MWAA).
  - Implement proper monitoring, logging, and alerting mechanisms.
  - Set up remote state backend for Terraform (e.g., S3 with DynamoDB for state locking).
  - Enforce code reviews and approvals in your CI/CD pipeline.
- **Testing**: Thoroughly test the infrastructure and applications in a staging environment before deploying to production.
- **Disaster Recovery**: Plan for backups and disaster recovery strategies.

---

## **Contact Information**

For questions, issues, or contributions, please contact:

- **Name**: Simon Aguilera
- **Email**: thesimonaguilera@gmail.com
- **GitHub**: [nomad3](https://github.com/nomad3)

---

**Disclaimer**: This project is provided as-is without any warranties. Use at your own risk. Always ensure compliance with your organization's policies and industry regulations.