output "bucket_id"  {
  value = aws_s3_bucket.tfadmin.id
}

output "dynamodb_table_id" {
    value = aws_dynamodb_table.tfadmin-dynamodb-lock.id
  }
