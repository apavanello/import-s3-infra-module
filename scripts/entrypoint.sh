#!/bin/sh
set -e

# Wait for LocalStack to be ready
echo "Waiting for LocalStack..."
sleep 5

# Initialize Terraform
echo "Initializing Terraform..."
terraform init

BUCKET_NAME="my-local-bucket"
export TF_VAR_bucket_name="$BUCKET_NAME"

# Check if bucket exists
echo "Checking if bucket $BUCKET_NAME exists..."
if aws s3 ls "s3://$BUCKET_NAME" 2>&1 | grep -q 'NoSuchBucket'; then
  echo "Bucket does not exist. It will be created by Terraform."
  # Ensure no import block exists
  rm -f import.tf
else
  echo "Bucket exists. Generating import block..."
  # Generate import.tf to use Terraform's native import block
  cat <<EOF > import.tf
import {
  to = module.s3_local.aws_s3_bucket.this
  id = var.bucket_name
}
EOF
fi

# Apply Terraform configuration
echo "Applying Terraform configuration..."
terraform apply -auto-approve
