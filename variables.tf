variable "region" {
  default = "us-east-1"
}

variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "db_name" {
  default = "mydb"
}

variable "db_user" {
  default = "admin"
}

variable "db_password" {
  default = "StrongPassword123"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "ami_id" {
  description = "Amazon Linux 2 AMI"
  default     = "ami-0c55b159cbfafe1f0"
}

variable "key_name" {
  description = "SSH Key Pair name"
}
