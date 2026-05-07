# ============================================================
# VARIABLES.TF — All variables are defined here
# Values are loaded from terraform.tfvars
# ============================================================

variable "project_name" {
  description = "Project name — used as prefix for all resource names"
  type        = string
  default     = "demo-project"
}

variable "environment" {
  description = "Environment: dev, staging, or prod"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod."
  }
}

variable "aws_region" {
  description = "AWS region (not critical for LocalStack but required)"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC (IP range)"
  type        = string
  default     = "10.0.0.0/16"
  # Covers 10.0.0.1 - 10.0.255.255 (65,536 IP addresses)
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
  # Covers 10.0.1.1 - 10.0.1.255 (256 IP addresses)
}

variable "ami_id" {
  description = "Amazon Machine Image ID for EC2 (fake ID used with LocalStack)"
  type        = string
  default     = "ami-00000000000000000"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
  # t2.micro = 1 vCPU, 1GB RAM — free under AWS Free Tier
}
