# ============================================================
# PROVIDER.TF — Terraform'a hangi cloud ile konuşacağını söyler
# LocalStack: AWS'yi local makinende simüle eder (ücretsiz!)
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

# LocalStack için AWS provider ayarları
provider "aws" {
  region = var.aws_region

  # ── LocalStack bağlantı ayarları ─────────────────────────
  # LocalStack her AWS servisini localhost'ta farklı porta yönlendirir
  endpoints {
    ec2 = "http://localhost:4566"
    iam = "http://localhost:4566"
    s3  = "http://localhost:4566"
  }

  # LocalStack sahte credential kabul eder
  access_key = "test"
  secret_key = "test"

  # LocalStack bazı AWS validasyonlarını atlar
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # ── Gerçek AWS kullanmak istersen ──────────────────────────
  # Üstteki tüm 'endpoints' ve 'skip_*' bloklarını sil,
  # access_key/secret_key satırlarını kaldır,
  # AWS CLI ile 'aws configure' yap → otomatik okur.
}
