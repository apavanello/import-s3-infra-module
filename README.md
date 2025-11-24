# Terraform S3 LocalStack Import/Create

This project demonstrates a Terraform setup that manages an S3 bucket in LocalStack. It features a smart conditional logic that:
1.  **Creates** the bucket if it doesn't exist.
2.  **Imports** the bucket if it already exists in LocalStack but is not in the Terraform state.

## Prerequisites

-   [Docker](https://www.docker.com/)
-   [Docker Compose](https://docs.docker.com/compose/)

## Getting Started

To start the infrastructure, simply run:

```bash
docker-compose up --build
```

This command will:
1.  Start a **LocalStack** container (simulating AWS S3).
2.  Build and run a **Terraform Runner** container.
3.  Execute the `scripts/entrypoint.sh` script which handles the logic.

## How It Works

The core logic resides in `scripts/entrypoint.sh`.

1.  **Check Existence**: The script uses `aws s3 ls` to check if the target bucket exists in LocalStack.
2.  **Conditional Import**:
    -   **If Bucket Exists**: The script dynamically generates a Terraform `import` block in `import.tf`. This tells Terraform to adopt the existing bucket into its state.
    -   **If Bucket Missing**: The script ensures `import.tf` is empty (or removed), allowing Terraform to create the bucket as a new resource.
3.  **Apply**: Finally, `terraform apply` is run to enforce the desired state (bucket configuration, policy, folders).

## Project Structure

```
.
├── docker-compose.yml       # Orchestration for LocalStack and Runner
├── Dockerfile               # Custom image with Terraform + AWS CLI + Python
├── main.tf                  # Main Terraform entry point
├── provider.tf              # AWS Provider configured for LocalStack
├── variables.tf             # Project variables
├── import.tf                # Placeholder for dynamic import block
├── modules/
│   └── s3-local/            # Reusable S3 module
├── policies/
│   └── my-local-bucket.json # Bucket policy (filename matches bucket name)
└── scripts/
    └── entrypoint.sh        # Logic script for conditional import
```

## Customization

### Changing Bucket Name
Update the `default` value in `variables.tf` or pass a `TF_VAR_bucket_name` environment variable in `docker-compose.yml`.

### Changing Policy
Edit the JSON file in `policies/`. Ensure the filename matches your bucket name (e.g., `my-new-bucket.json`).

### Adding Folders
Modify the `folders` variable in `variables.tf` to add or remove default folders created in the bucket.
