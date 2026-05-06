# ============================================================
# OUTPUTS.TF — terraform apply sonrası ekrana yazdırılan bilgiler
# ============================================================

output "vpc_id" {
  description = "Oluşturulan VPC'nin ID'si"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "Public subnet ID'si"
  value       = aws_subnet.public.id
}

output "security_group_id" {
  description = "Web security group ID'si"
  value       = aws_security_group.web.id
}

output "instance_id" {
  description = "EC2 instance ID'si"
  value       = aws_instance.web.id
}

output "instance_public_ip" {
  description = "EC2 public IP adresi"
  value       = aws_instance.web.public_ip
}

output "project_summary" {
  description = "Proje özeti"
  value = {
    project     = var.project_name
    environment = var.environment
    region      = var.aws_region
    vpc_cidr    = var.vpc_cidr
  }
}
