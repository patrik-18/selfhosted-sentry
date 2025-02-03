resource "kubernetes_config_map" "aws_auth" {
  depends_on = [aws_eks_cluster.eks]

  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = jsonencode([
      {
        rolearn  = aws_iam_role.node_role.arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes"]
      },
      {
        rolearn  = "arn:aws:iam::688567297177:role/aws-reserved/sso.amazonaws.com/eu-central-1/AWSReservedSSO_AdministratorAccess_1b62506be57cbea2"
        username = "pkristel"
        groups   = ["system:masters"]
      }
    ])

    mapUsers = jsonencode([
      {
        userarn  = var.iam_users[0]
        username = "admin"
        groups   = ["system:masters"]
      }
    ])
  }
}
