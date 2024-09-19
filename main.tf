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
  ami_id            = "ami-12345678"  # valid AMI ID here
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
  password            = "password123"  # secure this password
  parameter_group_name = "default.mysql8.0"
  security_group_id   = module.security_groups.ec2_security_group_id
}
