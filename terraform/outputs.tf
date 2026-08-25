# EC2 Instance Public IP
output "instance_public_ip" {
  description = "Public IP address of EC2 instance"
  value       = aws_instance.app.public_ip
}

output "instance_public_dns" {
  description = "Public DNS name of EC2 instance"
  value       = aws_instance.app.public_dns
}

# Route 53 Outputs
output "route53_nameservers" {
  description = "Route 53 nameservers (update at domain registrar)"
  value       = var.domain_name != "" ? aws_route53_zone.main[0].name_servers : null
}

output "route53_zone_id" {
  description = "Route 53 hosted zone ID"
  value       = var.domain_name != "" ? aws_route53_zone.main[0].zone_id : null
}

# VPC Outputs
output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "Public subnet ID"
  value       = aws_subnet.public.id
}

# Security Group Outputs
output "ec2_security_group_id" {
  description = "EC2 security group ID"
  value       = aws_security_group.ec2.id
}

# SSH Command
output "ssh_command" {
  description = "Command to SSH into the instance"
  value       = "ssh -i your-key.pem ubuntu@${aws_instance.app.public_ip}"
}

# Application URLs
output "app_url" {
  description = "Application URL"
  value       = var.domain_name != "" ? "https://${var.domain_name}" : "http://${aws_instance.app.public_ip}"
}
