# AWS Region
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

# Environment
variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

# Application name
variable "app_name" {
  description = "Application name"
  type        = string
  default     = "dream-vacations"
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# Subnet Configuration
variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

# EC2 Configuration
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"
}

# Domain Configuration
variable "domain_name" {
  description = "Domain name for the application"
  type        = string
  default     = ""
}

# Database Configuration
variable "db_name" {
  description = "Database name"
  type        = string
  default     = "dream_vacations_db"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "dreamvacations"
  sensitive   = true
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

# Docker Hub Configuration
variable "docker_username" {
  description = "Docker Hub username"
  type        = string
}

variable "docker_token" {
  description = "Docker Hub access token"
  type        = string
  sensitive   = true
}
