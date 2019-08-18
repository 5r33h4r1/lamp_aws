variable "profile" {
  description = "AWS Profile to be used (configured in awscli)"

}


variable "prefix" {
  description = "Prefix to all resources as part of common naming"
  default     = "gvktech"
}

variable "region" {
  description = "Prefix to all resources as part of common naming"
  default     = "us-west-2"
}


variable "vm_count" {
  description = "Number of ec2 instances"
  default     = 1
}


variable "ec2_instance_type" {
  description = "Size of ec2 instance ex t2.micro/m4large"
  default     = "t2.micro"

}

variable "key_pair" {
  description = "Keypair created in ec2. Should have with you to access ec2"

}

variable "vpc-fullcidr" {
  description = "CIDR block for the VPN"
  default     = "10.0.0.0/16"
}


variable "Subnet-web-CIDR" {

  description = "CIDR block for web Subnet"
  default     = "10.0.1.0/24"
}
