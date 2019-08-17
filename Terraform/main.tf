provider "aws" {
  version = "2.23.0"
  #shared_credentials_file = "/Users/kiran/.aws/credentials"
  profile = "${var.profile}"
  region  = "${var.region}"
}
