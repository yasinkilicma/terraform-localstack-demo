# ============================================================
# OUTPUTS.TF — Values displayed after terraform apply
# ============================================================

output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.main.id
}

output "subnet_id" {
  description = "Public subnet ID"
  value       = aws_subnet.public.id
}

output "security_group_id" {
  description = "Web security group ID"
  value       = aws_security_group.web.id
}

output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.web.id
}

output "instance_public_ip" {
  description = "EC2 public IP address"
  value       = aws_instance.web.public_ip
}

output "project_summary" {
  description = "Project summary"
  value = {
    project     = var.project_name
    environment = var.environment
    region      = var.aws_region
    vpc_cidr    = var.vpc_cidr
  }
}
