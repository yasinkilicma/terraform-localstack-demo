# ============================================================
# TERRAFORM.TFVARS — Değişkenlerin gerçek değerleri
# ⚠️  Hassas bilgi (şifre, API key) buraya YAZMA → .gitignore'a ekle
# ============================================================

project_name  = "localstack-demo"
environment   = "dev"
aws_region    = "us-east-1"
vpc_cidr      = "10.0.0.0/16"
subnet_cidr   = "10.0.1.0/24"
ami_id        = "ami-b7e22763"
instance_type = "t2.micro"
