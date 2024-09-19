variable "allocated_storage" {
  description = "RDS instance allocated storage"
  type        = number
}

variable "engine" {
  description = "Database engine (e.g., mysql, postgres)"
  type        = string
}

variable "instance_class" {
  description = "Instance class for the RDS"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "username" {
  description = "Master username"
  type        = string
}

variable "password" {
  description = "Master password"
  type        = string
}

variable "parameter_group_name" {
  description = "Parameter group name"
  type        = string
}

variable "security_group_id" {
  description = "Security Group ID for RDS"
  type        = string
}
