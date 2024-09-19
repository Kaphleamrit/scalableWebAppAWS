variable "name" {
  description = "Name of the Load Balancer"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security Group ID for the Load Balancer"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "tags" {
  description = "Tags for the ALB"
  type        = map(string)
}
