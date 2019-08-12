variable "prefix" {
  description = "Prefix to all resources as part of common naming"
  default = "gvktech"
}

variable "region" {
  description = "Prefix to all resources as part of common naming"
  default = "us-west-2"
}


variable "vm_count" {
  description = "Number of ec2 instances"
  default = 1
}


variable "ec2_instance_type" {
  description = "Size of ec2 instance ex t2.micro/m4large"
  default = "t2.micro"

}

variable "key_pair" {
  description = "Keypair created in ec2. Should have with you to access ec2"

}
