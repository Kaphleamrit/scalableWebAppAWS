variable "name" {
  description = "Name of the ASG"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the launch configuration"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID for the EC2 instances"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs for the ASG"
  type        = list(string)
}

variable "target_group_arn" {
  description = "Target group ARN for the ALB"
  type        = string
}

variable "desired_capacity" {
  description = "Desired capacity of the ASG"
  type        = number
}

variable "max_size" {
  description = "Maximum size of the ASG"
  type        = number
}

variable "min_size" {
  description = "Minimum size of the ASG"
  type        = number
}
