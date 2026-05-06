# ============================================================
# MAIN.TF — Ana altyapı tanımları
# LocalStack üzerinde çalışır (ücretsiz, local AWS simülasyonu)
# ============================================================

# ── VPC (Virtual Private Cloud) ──────────────────────────────
# Tüm kaynaklarımızın yaşadığı izole ağ
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-vpc"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# ── SUBNET ───────────────────────────────────────────────────
# VPC içinde bir alt ağ dilimi
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-public-subnet"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# ── INTERNET GATEWAY ─────────────────────────────────────────
# VPC'nin internete çıkış kapısı
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name        = "${var.project_name}-igw"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# ── ROUTE TABLE ──────────────────────────────────────────────
# Trafik yönlendirme kuralları
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name        = "${var.project_name}-public-rt"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# Route table'ı subnet'e bağla
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# ── SECURITY GROUP ────────────────────────────────────────────
# Firewall kuralları — hangi trafiğe izin verilir?
resource "aws_security_group" "web" {
  name        = "${var.project_name}-sg"
  description = "Web sunucusu icin guvenlik grubu"
  vpc_id      = aws_vpc.main.id

  # Gelen trafik: SSH (port 22)
  ingress {
    description = "SSH erisimi"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Gelen trafik: HTTP (port 80)
  ingress {
    description = "HTTP web trafigi"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Giden trafik: Her şeye izin ver
  egress {
    description = "Tum cikan trafige izin ver"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-sg"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# ── EC2 INSTANCE ─────────────────────────────────────────────
# Sanal sunucumuz
resource "aws_instance" "web" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]

  # Sunucu ilk açılışında çalışacak komutlar
  user_data = <<-EOF
    #!/bin/bash
    echo "Merhaba Terraform! Sunucu hazir." > /tmp/hello.txt
    echo "Proje: ${var.project_name}" >> /tmp/hello.txt
  EOF

  tags = {
    Name        = "${var.project_name}-web-server"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
