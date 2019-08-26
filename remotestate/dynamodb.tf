# Dynamo DB Table for State lock

# create a dynamodb table for locking the state file

resource "aws_dynamodb_table" "tfadmin-dynamodb-lock" {
  name = "${var.prefix}"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "${var.prefix}"
    Environment = "${var.tag_environment}"
  }
}
