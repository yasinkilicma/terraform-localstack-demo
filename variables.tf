# ============================================================
# VARIABLES.TF — Tüm değişkenler burada tanımlanır
# Değerleri terraform.tfvars dosyasından alır
# ============================================================

variable "project_name" {
  description = "Projenin adı — tüm resource isimlerinde kullanılır"
  type        = string
  default     = "demo-project"
}

variable "environment" {
  description = "Ortam: dev, staging, prod"
  type        = string
  default     = "dev"

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment sadece: dev, staging, prod olabilir."
  }
}

variable "aws_region" {
  description = "AWS bölgesi (LocalStack için önemli değil ama gerekli)"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC için CIDR bloğu (IP aralığı)"
  type        = string
  default     = "10.0.0.0/16"
  # 10.0.0.1 - 10.0.255.255 arası 65,536 IP adresi
}

variable "subnet_cidr" {
  description = "Subnet için CIDR bloğu"
  type        = string
  default     = "10.0.1.0/24"
  # 10.0.1.1 - 10.0.1.255 arası 256 IP adresi
}

variable "ami_id" {
  description = "EC2 için Amazon Machine Image ID (LocalStack'te fake ID kullanılır)"
  type        = string
  default     = "ami-00000000000000000"
}

variable "instance_type" {
  description = "EC2 sunucu tipi"
  type        = string
  default     = "t2.micro"
  # t2.micro = 1 vCPU, 1GB RAM — AWS Free Tier'da ücretsiz
}
