variable "cluster_name" {
  description = "Name of the EKS cluster"
}

variable "k8s_version" {
  description = "Kubernetes version"
  default     = "1.27"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "cluster_tags" {
  description = "Tags for the EKS cluster"
  type        = map(string)
  default     = {}
}

variable "instance_types" {
  description = "Instance types for the node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_count" {
  description = "Desired number of nodes in the group"
  default     = 2
}

variable "node_min" {
  description = "Minimum number of nodes"
  default     = 1
}

variable "node_max" {
  description = "Maximum number of nodes"
  default     = 4
}

variable "node_tags" {
  description = "Tags for the node group"
  type        = map(string)
  default     = {}
}
