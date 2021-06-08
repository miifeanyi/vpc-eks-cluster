resource "aws_dynamodb_table" "statelock-table" {
  name         = "statelocking-dynamodb"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-statelock-table"
    Environment = "dev"
  }
}
