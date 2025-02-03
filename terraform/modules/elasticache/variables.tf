variable "subnet_ids" {
  description = "List of private subnets for Redis"
  type        = list(string)
}

variable "security_group" {
  description = "Security group for Redis"
  type        = string
}
