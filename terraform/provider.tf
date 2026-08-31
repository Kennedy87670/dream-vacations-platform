terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Remote state storage in S3
 backend "s3" {
  key            = "capstone/terraform.tfstate"
  dynamodb_table = "terraform-locks"
  encrypt        = true
}


}

# AWS Provider Configuration
provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Application = var.app_name
      ManagedBy   = "Terraform"
    }
  }
}
