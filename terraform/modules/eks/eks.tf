resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_role.arn
  version  = var.k8s_version

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  tags = merge(
    {
      Name = var.cluster_name
    },
    var.cluster_tags
  )
}

resource "aws_iam_role" "eks_role" {
  name = "${var.cluster_name}-eks-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_eks_node_group" "eks_nodes" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = var.subnet_ids
  instance_types  = var.instance_types

  scaling_config {
    desired_size = var.node_count
    min_size     = var.node_min
    max_size     = var.node_max
  }

  tags = merge(
    {
      Name = "${var.cluster_name}-node-group"
    },
    var.node_tags
  )
}

resource "aws_iam_role" "node_role" {
  name = "${var.cluster_name}-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

output "eks_cluster_name" {
  description = "EKS Cluster Name"
  value       = aws_eks_cluster.eks.name
}

output "eks_oidc_provider" {
  description = "EKS OIDC Provider"
  value       = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}
