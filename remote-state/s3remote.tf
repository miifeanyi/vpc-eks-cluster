resource "aws_s3_bucket" "bucket" {
  bucket = "chimz-bucket"
  acl    = "private"

  versioning {
    enabled = true
  }
}

terraform {
  backend "s3" {
    bucket         = "chimz-bucket"
    key            = "project/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "statelocking-dynamodb"
  }
}
