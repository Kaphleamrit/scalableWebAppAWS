# Scalable Web Application on AWS with Terraform Modules 🚀

This project demonstrates a scalable web application setup on AWS using Terraform modules for a clean and reusable infrastructure-as-code design. The project is modularized into separate components, including VPC, Security Groups, Auto Scaling Group (ASG), Application Load Balancer (ALB), and RDS.

## Modules Structure 🗂️

The infrastructure is organized into the following modules:

1. **VPC Module**: Provisions a VPC with public subnets and an Internet Gateway.
2. **Security Groups Module**: Manages security groups for ALB, ASG, and RDS.
3. **ALB Module**: Configures an Application Load Balancer with listeners and target groups.
4. **ASG Module**: Sets up an Auto Scaling Group and Launch Configuration for EC2 instances.
5. **RDS Module**: Creates an RDS instance for the application database.

## Usage ⚙️

### 1. Clone the Repository

```bash
git clone https://github.com/Kaphleamrit/scalableWebAppAWS.git
cd scalableWebAppAWS
```

### 2. Initialize and Apply Terraform

```bash
terraform init
terraform apply
```

### 3. Module Variables

Each module has its own set of input variables defined in the `variables.tf` file. Modify these variables in the root `main.tf` file or use a `terraform.tfvars` file to provide custom values.

### 4. Module Outputs

Modules produce useful outputs like VPC ID, Subnet IDs, Security Group IDs, ALB ARN, ASG Name, and RDS Endpoint. These can be used for integration with other resources or applications.

## Example Root Module

```hcl
provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
}

module "security_groups" {
  source    = "./modules/security-groups"
  vpc_id    = module.vpc.vpc_id
  tags      = { Environment = "dev" }
}

module "alb" {
  source            = "./modules/alb"
  name              = "my-alb"
  subnets           = module.vpc.public_subnet_ids
  security_group_id = module.security_groups.alb_security_group_id
  vpc_id            = module.vpc.vpc_id
  tags              = { Environment = "dev" }
}

module "asg" {
  source            = "./modules/asg"
  name              = "my-asg"
  ami_id            = "ami-12345678"  # Replace with a valid AMI ID
  instance_type     = "t2.micro"
  security_group_id = module.security_groups.ec2_security_group_id
  subnets           = module.vpc.public_subnet_ids
  target_group_arn  = module.alb.target_group_arn
  desired_capacity  = 2
  max_size          = 3
  min_size          = 1
}

module "rds" {
  source              = "./modules/rds"
  allocated_storage   = 20
  engine              = "mysql"
  instance_class      = "db.t2.micro"
  db_name             = "mydb"
  username            = "admin"
  password            = "password123"  # Use secure method for passwords
  parameter_group_name = "default.mysql8.0"
  security_group_id   = module.security_groups.ec2_security_group_id
}
```

## Requirements 📋

- Terraform v0.13+
- AWS Account and IAM permissions to provision the resources
- AWS CLI configured

## Contributing 🤝

Feel free to fork this repository, make improvements, and submit a pull request! Contributions are welcome.

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Project by [Amrit Kafle](https://github.com/Kaphleamrit)** 💻
