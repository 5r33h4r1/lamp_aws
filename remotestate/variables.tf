variable "prefix" {
  description = "Prefix to all resources as part of common naming"
  default     = "dev"
}

variable "region" {
  description = "Prefix to all resources as part of common naming"
  default     = "us-west-2"
}



variable "tag_environment" {
  description = "Tag value for Environment viz., Dev, Test, QA, Staging, Production"
  default = "Dev"

}
