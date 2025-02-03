variable "db_username" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "db_subnet_group" {
  description = "DB Subnet Group"
  type        = string
}

variable "security_group" {
  description = "Security Group for DB"
  type        = string
}

variable "subnet_ids" {
  description = "List of private subnets for RDS"
  type        = list(string)
}
