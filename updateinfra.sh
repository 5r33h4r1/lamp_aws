#!/bin/bash


echo "Updating infra"



# Change to Terraform-main directory
cd Terraform-main

# Initialize and apply Terraform config

terraform init
terraform apply -auto-approve
