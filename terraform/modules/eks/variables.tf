variable "cluster_name" {
  description = "Name of the EKS cluster"
}

variable "k8s_version" {
  description = "Kubernetes version"
  default     = "1.31"
}

variable "subnet_ids" {
  description = "List of private subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "node_count" {
  description = "Desired number of nodes"
  default     = 2
}

variable "node_min" {
  description = "Minimum number of nodes"
  default     = 1
}

variable "node_max" {
  description = "Maximum number of nodes"
  default     = 3
}

variable "instance_types" {
  description = "EC2 instance types for the node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "iam_users" {
  description = "IAM users to map to the EKS cluster"
  type        = list(string)
}

variable "iam_roles" {
  description = "IAM roles to map to the EKS cluster"
  type        = list(string)
}
