module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"
  bucket = "eks.bucket"
  acl    = "private"
  versioning = {
    enabled = false
  }
}

resource "aws_iam_policy" "policy1" {
  name        = "eks.s3policy"
  description = "s3EKSPolicy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::eks.bucket/*"
      },
    ]
  })
}
