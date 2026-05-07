# 🏗️ Terraform LocalStack Demo

> Infrastructure as Code (IaC) practice using LocalStack — simulate AWS locally for free.

## 📋 What You'll Learn

- Core Terraform concepts: provider, resource, variable, output
- AWS networking: VPC → Subnet → Internet Gateway → Route Table
- Security: Security Groups (firewall rules)
- EC2 instance management
- Infrastructure as Code (IaC) principles

## 🏛️ Infrastructure Overview

```
Internet
    │
    ▼
Internet Gateway
    │
    ▼
VPC (10.0.0.0/16)
    │
    ▼
Public Subnet (10.0.1.0/24)
    │
    ├── Route Table (0.0.0.0/0 → IGW)
    │
    ├── Security Group
    │       ├── Inbound: SSH (22), HTTP (80)
    │       └── Outbound: All
    │
    └── EC2 Instance (t2.micro)
```

## 📁 Project Structure

```
terraform-localstack-demo/
├── provider.tf        # AWS provider + LocalStack connection
├── main.tf            # Core infrastructure: VPC, Subnet, EC2, SG
├── variables.tf       # Variable definitions
├── terraform.tfvars   # Variable values
├── outputs.tf         # Values displayed after apply
├── scripts/
│   └── setup.sh       # Automated setup script (Mac)
└── .gitignore         # Files excluded from Git
```

## ⚙️ Setup

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- [Terraform](https://developer.hashicorp.com/terraform/install) `>= 1.0.0`
- [LocalStack CLI](https://docs.localstack.cloud/getting-started/installation/)

### Quick Start (Mac)

```bash
# Start LocalStack
localstack start -d

# Register a fake AMI for LocalStack
curl -s -X POST "http://localhost:4566/ec2/register-image" \
  -d "Action=RegisterImage&Name=test-ami&Description=test&RootDeviceName=/dev/xvda&BlockDeviceMapping.1.DeviceName=/dev/xvda&BlockDeviceMapping.1.Ebs.VolumeSize=8"

# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Apply infrastructure
terraform apply

# Destroy everything
terraform destroy
```

## 🔍 Core Terraform Commands

| Command | Description |
|---------|-------------|
| `terraform init` | Download providers, prepare working directory |
| `terraform fmt` | Auto-format code |
| `terraform validate` | Check for syntax errors |
| `terraform plan` | Preview changes (dry-run) |
| `terraform apply` | Create or update infrastructure |
| `terraform destroy` | Destroy all resources |
| `terraform show` | Show current state |
| `terraform output` | Display output values |

## 📚 Key Concepts

### Resource
```hcl
resource "aws_vpc" "main" {  # "aws_vpc" = type, "main" = name
  cidr_block = "10.0.0.0/16"
}
```

### Variable
```hcl
variable "project_name" {
  type    = string
  default = "demo"
}
# Used as: var.project_name
```

### Output
```hcl
output "vpc_id" {
  value = aws_vpc.main.id
}
# Printed after terraform apply
```

### Reference
```hcl
subnet_id = aws_subnet.public.id
# Terraform automatically resolves dependencies
```

## 🔐 Security Notes

- Never commit `.tfstate` files to Git (may contain sensitive data)
- Never put real AWS keys in `terraform.tfvars`
- For production, use [Terraform Cloud](https://app.terraform.io) or S3 backend

## 🚀 Next Steps

- [ ] Change values in `terraform.tfvars` and re-apply
- [ ] Add a new security group rule (HTTPS port 443)
- [ ] Add a second EC2 instance
- [ ] Explore [Terraform Registry](https://registry.terraform.io)
- [ ] Try with real AWS Free Tier

## 📖 Resources

- [Terraform Docs](https://developer.hashicorp.com/terraform/docs)
- [LocalStack Docs](https://docs.localstack.cloud)
- [AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

---
*This project was created for learning Terraform and Infrastructure as Code.*
