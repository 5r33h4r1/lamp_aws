terraform {
  backend "s3" {
    bucket = "tf-ranbaddi-be"
    key    = "tf-ranbaddi-be/tfremote.tfstate"
    region = "us-west-2"
    dynamodb_table = "tf-ranbaddi-be-lock-dynamo"
  }
}



data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "tf-ranbaddi-be"
    key    = "tf-ranbaddi-be/tfremote.tfstate"
    region = "us-west-2"
  }
}



# Dynamo DB Table for State lock

# create a dynamodb table for locking the state file

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "tf-ranbaddi-be-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "ranbaddi-statelock"
  }
}
