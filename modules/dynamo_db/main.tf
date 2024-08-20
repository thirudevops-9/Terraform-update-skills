# create dynamo_db table 
resource "aws_dynamodb_table" "terraform_locks" {
  name         = var.dynamodb_name
  hash_key     = "LockID"
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = var.dynamodb_name
    
  }
}