#!/bin/bash
# ============================================================
# SETUP.SH — LocalStack + Terraform kurulum scripti
# Mac için yazılmıştır (Homebrew kullanır)
# ============================================================

set -e  # Hata olursa dur

echo "🚀 Terraform LocalStack Demo - Kurulum Başlıyor"
echo "================================================"

# ── 1. Homebrew kontrolü ──────────────────────────────────
if ! command -v brew &> /dev/null; then
  echo "❌ Homebrew bulunamadı. Önce kur: https://brew.sh"
  exit 1
fi
echo "✅ Homebrew mevcut"

# ── 2. Terraform kurulumu ─────────────────────────────────
if ! command -v terraform &> /dev/null; then
  echo "📦 Terraform kuruluyor..."
  brew tap hashicorp/tap
  brew install hashicorp/tap/terraform
else
  echo "✅ Terraform mevcut: $(terraform version -json | python3 -c 'import sys,json; print(json.load(sys.stdin)["terraform_version"])')"
fi

# ── 3. Docker kontrolü ────────────────────────────────────
if ! command -v docker &> /dev/null; then
  echo "❌ Docker bulunamadı. Docker Desktop kur: https://www.docker.com/products/docker-desktop"
  exit 1
fi

if ! docker info &> /dev/null; then
  echo "❌ Docker çalışmıyor. Docker Desktop'ı başlat."
  exit 1
fi
echo "✅ Docker çalışıyor"

# ── 4. LocalStack kurulumu ────────────────────────────────
if ! command -v localstack &> /dev/null; then
  echo "📦 LocalStack CLI kuruluyor..."
  brew install localstack/tap/localstack-cli
else
  echo "✅ LocalStack CLI mevcut"
fi

# ── 5. LocalStack başlat ──────────────────────────────────
echo ""
echo "🔄 LocalStack başlatılıyor (Docker container)..."
localstack start -d
echo "⏳ LocalStack'in hazır olması bekleniyor..."
sleep 5

# ── 6. Terraform başlat ───────────────────────────────────
echo ""
echo "🔄 Terraform başlatılıyor..."
cd "$(dirname "$0")"
terraform init

echo ""
echo "================================================"
echo "✅ Kurulum tamamlandı!"
echo ""
echo "Sıradaki adımlar:"
echo "  terraform plan    → Ne yapılacağını gör"
echo "  terraform apply   → Altyapıyı kur"
echo "  terraform destroy → Her şeyi sil"
echo "================================================"
