terraform {
  backend "s3" {
    bucket = "baddilab"
    key    = "baddilab/tfremote.tfstate"
    region = "us-west-2"
    dynamodb_table = "baddilab"
  }
}
