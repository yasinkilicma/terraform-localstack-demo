# ============================================================
# PROVIDER.TF — Tells Terraform which cloud provider to use
# LocalStack: simulates AWS on your local machine (free!)
# ============================================================

terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# AWS provider configured for LocalStack
provider "aws" {
  region = var.aws_region

  # ── LocalStack connection settings ───────────────────────
  # LocalStack routes every AWS service to localhost
  endpoints {
    ec2 = "http://localhost:4566"
    iam = "http://localhost:4566"
    s3  = "http://localhost:4566"
  }

  # LocalStack accepts fake credentials
  access_key = "test"
  secret_key = "test"

  # Skip validations not needed for LocalStack
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # ── To use real AWS instead ───────────────────────────────
  # Remove all 'endpoints' and 'skip_*' blocks above,
  # remove access_key/secret_key lines,
  # run 'aws configure' via AWS CLI → credentials auto-loaded.
}
