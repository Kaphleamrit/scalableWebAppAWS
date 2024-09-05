
# Web Application Architecture Deployment using Terraform

This Terraform project deploys a complete AWS infrastructure for hosting a scalable web application. The infrastructure includes a VPC, public and private subnets, an Auto Scaling Group (ASG), an Application Load Balancer (ALB), an RDS database, an Elastic File System (EFS), and security groups spread across multiple Availability Zones (AZs).

## Architecture Overview

The architecture consists of the following components:

- **VPC**: A Virtual Private Cloud to host all components of the web application.
- **Subnets**: Public and private subnets spread across three Availability Zones.
- **Auto Scaling Group (ASG)**: EC2 instances to automatically scale the application based on demand.
- **Application Load Balancer (ALB)**: Distributes incoming HTTP requests to EC2 instances.
- **Amazon RDS (MySQL)**: A managed relational database for the application.
- **Amazon EFS**: A shared file system accessible by EC2 instances.
- **Security Groups**: Manage inbound and outbound traffic to ensure secure communication between services.

## Prerequisites

Before you begin, make sure you have the following:

- **AWS Account**: Access to create resources in AWS.
- **Terraform Installed**: Terraform v1.0+ installed on your local machine.
- **AWS CLI Configured**: AWS CLI set up with your credentials.
- **Key Pair**: An existing EC2 key pair in the target AWS region for SSH access to EC2 instances.

## Project Structure

- **`main.tf`**: Main Terraform configuration file.
- **`vpc.tf`**: VPC and subnet configurations.
- **`security_groups.tf`**: Security groups for ALB, EC2, and RDS.
- **`alb.tf`**: Application Load Balancer configuration.
- **`asg.tf`**: Auto Scaling Group and EC2 launch configuration.
- **`rds.tf`**: Amazon RDS (MySQL) configuration.
- **`efs.tf`**: Amazon Elastic File System configuration.
- **`outputs.tf`**: Outputs such as ALB DNS and RDS endpoint.
- **`variables.tf`**: Variable definitions for the project.

## Variables

The project uses the following variables defined in `variables.tf`:

- `region`: AWS region for deploying resources.
- `availability_zones`: List of availability zones in the target region.
- `db_name`: Name of the RDS MySQL database.
- `db_user`: Username for the RDS MySQL database.
- `db_password`: Password for the RDS MySQL database.
- `instance_type`: EC2 instance type for the Auto Scaling Group.
- `ami_id`: AMI ID for the EC2 instances.
- `key_name`: SSH Key Pair name for EC2 access.

## How to Deploy

### 1. Initialize Terraform

First, initialize the Terraform project by downloading the necessary providers and modules:

```bash
terraform init
```

### 2. Validate the Configuration

Validate the Terraform configuration to ensure everything is correct:

```bash
terraform validate
```

### 3. Apply the Configuration

Deploy the infrastructure by running the following command. Review the plan and confirm with `yes`:

```bash
terraform apply
```

### 4. View the Outputs

After a successful deployment, Terraform will display the outputs, including:

- **Load Balancer DNS**: The DNS name for the Application Load Balancer.
- **RDS Endpoint**: The endpoint for the RDS MySQL instance.

You can access the web application through the ALB DNS and connect to the MySQL database using the RDS endpoint.

## Components

### VPC and Subnets

- A VPC with CIDR `10.0.0.0/16`.
- Three public and three private subnets, one in each availability zone.
- An Internet Gateway for public subnet access.

### Application Load Balancer

- The ALB distributes incoming traffic to EC2 instances.
- Configured with a target group to register EC2 instances in the Auto Scaling Group.

### Auto Scaling Group (ASG)

- EC2 instances are launched in private subnets.
- The ASG automatically adjusts the number of EC2 instances based on load.
- Instances are registered with the ALB target group.

### RDS (MySQL)

- MySQL database is deployed in private subnets.
- Multi-AZ deployment ensures high availability and fault tolerance.

### Elastic File System (EFS)

- EFS provides shared storage accessible by all EC2 instances.
- EFS mount targets are deployed in private subnets in each availability zone.

### Security Groups

- **ALB Security Group**: Allows inbound traffic on port 80 (HTTP) from the internet.
- **Web Security Group**: Allows inbound traffic on port 80 from the ALB and port 2049 (NFS) from the EFS.
- **RDS Security Group**: Allows inbound traffic on port 3306 from the web servers.

## Clean Up

To avoid incurring charges for the AWS resources, destroy the infrastructure when you're done:

```bash
terraform destroy
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
