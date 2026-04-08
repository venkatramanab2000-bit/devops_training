terraform {
  backend "s3" {
    region = "ap-south-1"
    # Backend configuration will be provided via backend config files
    # Use: terraform init -backend-config=dev.backend.tfvars
    # Or:  terraform init -backend-config=prod.backend.tfvars
  }
}