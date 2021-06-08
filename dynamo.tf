module "dynamodb_table" {
  source = "terraform-aws-modules/dynamodb-table/aws"

  name     = "eks.table"
  hash_key = "id"

  attributes = [
    {
      name = "id"
      type = "N"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "staging"
  }
}

resource "aws_iam_policy" "policy2" {
  name        = "eks.dynamodbpolicy"
  description = "dynamodbEKSPolicy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:*",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:dynamodb:us-east-1:187852450557:table/eks.table/*"
      },
    ]
  })
}
