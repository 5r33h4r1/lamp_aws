#!/bin/bash



# Change to remotestate directory to create s3 and dynamodb for remote tfstate

cd remotestate
# Initialize terraform
terraform init
#Apply Terraform config
terraform apply -auto-approve

# Assign bucket_id and dynamodb_table_id to variables to update remotestate file in Terraform-main folder

backendbucket=$(terraform output bucket_id)
dynamodbtable=$(terraform output dynamodb_table_id)

 # Change to infra directory
sleep 20

cd ..


# Replace bucketname and dynamodb name in remotestate.tf file

sed -i "s/backendbucket/${backendbucket}/g" ./Terraform-main/remotestate.tf
sed -i "s/dynamodbtable/${dynamodbtable}/g" ./Terraform-main/remotestate.tf

echo "Building main infra"


# Change to Terraform-main directory
cd Terraform-main

# Initialize and apply Terraform config

terraform init
terraform apply -auto-approve
``
