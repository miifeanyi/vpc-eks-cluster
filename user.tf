module "iam_user" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"
  version = "~> 3.0"

  name          = "eks.user"
  force_destroy = false

  pgp_key = "keybase:test"

  password_reset_required = false
}

module "iam_iam-group-with-policies" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"
  version     = "2.3.0"
  name        = "eks-developers"
  group_users = ["module.iam_user.name"]
  custom_group_policies = [
    { name = "EKSDevPolicy"
      policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
          {
            Action = [
              "eks:DescribeNodegroup",
              "eks:ListNodegroups",
              "eks:DescribeCluster",
              "eks:ListClusters",
              "eks:AccessKubernetesApi",
              "ssm:GetParameter",
              "eks:ListUpdates",
              "eks:ListFargateProfiles"
            ]
            Effect   = "Allow"
            Resource = "*"
          },
        ]
  }) }]
}
