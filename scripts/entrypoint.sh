#!/bin/sh
set -e

# Wait for LocalStack to be ready
echo "Waiting for LocalStack..."
sleep 5

# Initialize Terraform
echo "Initializing Terraform..."
terraform init

# Apply Terraform configuration
echo "Applying Terraform configuration..."
terraform apply -auto-approve
