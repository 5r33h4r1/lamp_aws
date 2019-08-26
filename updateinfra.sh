#!/bin/bash


echo "Building main infra"



# Change to Terraform-main directory
cd Terraform-main

# Initialize and apply Terraform config

terraform init
terraform apply -auto-approve
