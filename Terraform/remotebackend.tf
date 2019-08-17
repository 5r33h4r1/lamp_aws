terraform {
  backend "s3" {
    bucket = "tf-ranbaddi"
    key    = "tf-ranbaddi/tfremote.tfstate"
    region = "us-west-2"
  }
}



data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "tf-ranbaddi"
    key    = "tf-ranbaddi/tfremote.tfstate"
    region = "us-west-2"
  }
}
