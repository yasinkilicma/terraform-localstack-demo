# 🏗️ Terraform LocalStack Demo

> Terraform öğrenmek için local AWS simülasyonu — para ödemeden, gerçek AWS hissiyle.

## 📋 Ne Öğreneceksin?

- Terraform'un temel kavramları (provider, resource, variable, output)
- AWS ağ altyapısı: VPC → Subnet → Internet Gateway → Route Table
- Güvenlik: Security Group (firewall kuralları)
- EC2 instance yönetimi
- Infrastructure as Code (IaC) prensibi

## 🏛️ Oluşturulan Altyapı

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

## 📁 Dosya Yapısı

```
terraform-localstack-demo/
├── provider.tf        # AWS provider + LocalStack bağlantısı
├── main.tf            # Ana altyapı: VPC, Subnet, EC2, SG
├── variables.tf       # Değişken tanımları
├── terraform.tfvars   # Değişken değerleri
├── outputs.tf         # Apply sonrası gösterilecek bilgiler
├── scripts/
│   └── setup.sh       # Otomatik kurulum scripti (Mac)
└── .gitignore         # GitHub'a gönderilmeyecek dosyalar
```

## ⚙️ Kurulum

### Gereksinimler
- [Docker Desktop](https://www.docker.com/products/docker-desktop) (LocalStack için)
- [Terraform](https://developer.hashicorp.com/terraform/install) `>= 1.0.0`
- [LocalStack CLI](https://docs.localstack.cloud/getting-started/installation/)

### Mac'te Otomatik Kurulum

```bash
chmod +x scripts/setup.sh
./scripts/setup.sh
```

### Manuel Kurulum

```bash
# 1. LocalStack'i başlat
localstack start -d

# 2. Terraform'u başlat (provider indirir)
terraform init

# 3. Ne yapılacağını gör (değişiklik yok, sadece plan)
terraform plan

# 4. Altyapıyı kur
terraform apply

# 5. Tüm kaynakları sil
terraform destroy
```

## 🔍 Temel Terraform Komutları

| Komut | Ne yapar? |
|-------|-----------|
| `terraform init` | Provider'ları indirir, çalışma dizini hazırlar |
| `terraform fmt` | Kodları otomatik formatlar |
| `terraform validate` | Syntax hatalarını kontrol eder |
| `terraform plan` | Değişiklikleri önizler (dry-run) |
| `terraform apply` | Altyapıyı oluşturur/günceller |
| `terraform destroy` | Tüm kaynakları siler |
| `terraform show` | Mevcut state'i gösterir |
| `terraform output` | Output değerlerini gösterir |

## 📚 Kavramlar

### Resource
```hcl
resource "aws_vpc" "main" {  # "aws_vpc" tip, "main" isim
  cidr_block = "10.0.0.0/16"
}
```
Terraform'a "bu kaynağı oluştur" diyorsun.

### Variable
```hcl
variable "project_name" {
  type    = string
  default = "demo"
}
```
Tekrar kullanılabilir değerler. `var.project_name` ile çağırırsın.

### Output
```hcl
output "vpc_id" {
  value = aws_vpc.main.id
}
```
`terraform apply` sonrası ekrana yazdırılan bilgiler.

### Reference (Referans)
```hcl
subnet_id = aws_subnet.public.id
# ↑ Başka bir resource'un değerini kullanıyoruz
# Terraform bağımlılığı otomatik çözüyor
```

## 🔐 Güvenlik Notları

- `.tfstate` dosyasını asla GitHub'a push etme (hassas bilgi içerir)
- Gerçek AWS key'lerini `terraform.tfvars`'a yazma
- Production'da [Terraform Cloud](https://app.terraform.io) veya S3 backend kullan

## 🚀 Sonraki Adımlar

- [ ] `terraform.tfvars` değerlerini değiştirip tekrar apply dene
- [ ] Yeni bir security group rule ekle (HTTPS port 443)
- [ ] İkinci bir EC2 instance ekle
- [ ] [Terraform Registry](https://registry.terraform.io)'yi keşfet
- [ ] Gerçek AWS Free Tier ile dene

## 📖 Kaynaklar

- [Terraform Docs](https://developer.hashicorp.com/terraform/docs)
- [LocalStack Docs](https://docs.localstack.cloud)
- [AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

---
*Bu proje Terraform öğrenmek amacıyla oluşturulmuştur.*
