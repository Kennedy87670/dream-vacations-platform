# Dream Vacations Platform

## Overview

A full-stack travel booking web application deployed on AWS with containerization, CI/CD pipelines, and infrastructure-as-code. The platform demonstrates production-ready DevOps practices including automated deployments, SSL security, and monitoring.

## Architecture

```
┌─────────────────────────────────────────────────────┐
│                    Internet                         │
└────────────────────────┬────────────────────────────┘
                         │
                  ┌──────▼──────┐
                  │   Route 53  │
                  │  (DNS / TLS)│
                  └──────┬──────┘
                         │
                  ┌──────▼──────────┐
                  │ Nginx Proxy     │
                  │ (SSL, Port 443) │
                  └──────┬──────────┘
                         │
        ┌────────────────┼────────────────┐
        │                │                │
   ┌────▼────┐    ┌─────▼─────┐   ┌─────▼──────┐
   │  React  │    │ Node.js   │   │ PostgreSQL │
   │Frontend │    │  Backend  │   │  Database  │
   │(Port    │    │  (Port    │   │ (Port 5432)│
   │ 3000)   │    │  5000)    │   │            │
   └─────────┘    └───────────┘   └────────────┘

Infrastructure: AWS EC2, VPC, Security Groups
CI/CD: GitHub Actions
IaC: Terraform
```

## Tech Stack

| Component | Technology |
|-----------|-----------|
| Frontend | React.js |
| Backend | Node.js / Express |
| Database | PostgreSQL |
| Containerization | Docker & Docker Compose |
| Cloud | AWS (EC2, VPC, Route 53) |
| Reverse Proxy | Nginx |
| SSL/TLS | Let's Encrypt / Certbot |
| CI/CD | GitHub Actions |
| Infrastructure | Terraform |
| Monitoring | CloudWatch (stretch goal) |

## Setup Instructions

### Prerequisites

- Docker and Docker Compose installed
- Node.js 18+ (for local development)
- Git
- AWS account (for deployment)
- GitHub account

### Local Development Setup

```bash
# 1. Clone the repository
git clone https://github.com/Kennedy87670/dream-vacations-platform.git
cd dream-vacations-platform

# 2. Create environment file
cp .env.example .env
# Edit .env with your configuration

# 3. Start the full stack
docker-compose up -d

# 4. Initialize database (if needed)
docker-compose exec db psql -U dreamvacations -d dream_vacations_db < db/init.sql

# 5. Access the application
# Frontend: http://localhost:3000
# Backend API: http://localhost:5000
# Database: localhost:5432
```

### Verify Local Deployment

```bash
# Check running containers
docker-compose ps

# View logs
docker-compose logs -f

# Test API endpoint
curl http://localhost:5000/api/health

# Stop the stack
docker-compose down
```

## Environment Variables

| Variable | Description | Example | Required |
|----------|-------------|---------|----------|
| `DB_HOST` | PostgreSQL hostname | `db` or `localhost` | ✓ |
| `DB_PORT` | PostgreSQL port | `5432` | ✓ |
| `DB_USER` | Database username | `dreamvacations` | ✓ |
| `DB_PASSWORD` | Database password | `secure-password-123` | ✓ |
| `DB_NAME` | Database name | `dream_vacations_db` | ✓ |
| `NODE_ENV` | Environment type | `development` / `production` | ✓ |
| `NODE_PORT` | Backend server port | `5000` | ✓ |
| `REACT_APP_API_URL` | Backend API URL | `http://localhost:5000` | ✓ |
| `REACT_APP_API_URL_PROD` | Production API URL | `https://yourdomain.com` | ✓ |

## Deployment Checklist

### Section 1: Git & Repository Setup
- [x] Create public GitHub repository
- [x] Set up `main` and `dev` branches
- [x] Configure branch protection on `main`
- [x] Write README skeleton

### Section 2: Shell Scripting
- [ ] Write environment setup script
- [ ] Write database backup script
- [ ] Write log rotation script
- [ ] Test idempotency

### Section 3: Containerization
- [ ] Create backend Dockerfile
- [ ] Create frontend Dockerfile
- [ ] Verify images build successfully
- [ ] Test containers run independently

### Section 4: Docker Compose
- [ ] Write docker-compose.yml
- [ ] Define all services (frontend, backend, database)
- [ ] Configure networking and volumes
- [ ] Test full stack with one command

### Section 5: CI/CD (GitHub Actions)
- [ ] Create CI workflow (PR builds/tests)
- [ ] Create CD workflow (merge to main)
- [ ] Push Docker images to registry
- [ ] Add status badges to README

### Section 6: Terraform (AWS Infrastructure)
- [ ] Create VPC and subnets
- [ ] Configure security groups
- [ ] Set up Route 53 hosted zone
- [ ] Configure remote state
- [ ] Validate with `terraform plan`

### Section 7: AWS Deployment
- [ ] Provision EC2 instance
- [ ] SSH access and deployment
- [ ] Verify app accessible by public IP

### Section 8: Domain & DNS
- [ ] Register free domain
- [ ] Create Route 53 hosted zone
- [ ] Update nameservers at registrar
- [ ] Create A record to EC2

### Section 9: Nginx & SSL
- [ ] Install and configure Nginx
- [ ] Set up reverse proxy rules
- [ ] Install Let's Encrypt certificate
- [ ] Configure auto-renewal
- [ ] Verify HTTPS access

### Section 10: Stretch Goals
- [ ] CloudWatch monitoring setup
- [ ] Application logging
- [ ] Performance dashboards

## Project Status

**Current Phase:** Section 1 - Git & Repository Setup ✓

**Next Steps:** 
1. Shell scripts for environment setup and database backups
2. Dockerize the application
3. Set up CI/CD pipelines
4. Deploy to AWS

## Getting Help

- Review the assignment requirements in the project documentation
- Check Docker Compose logs: `docker-compose logs <service>`
- Verify environment variables: `docker-compose config`
- Test API endpoints: `curl -vI http://localhost:5000/api/health`

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Let's Encrypt](https://letsencrypt.org/)
- [Nginx Documentation](https://nginx.org/en/docs/)

---

**Author:** Kennedy (Junior DevOps Engineer)  
**Last Updated:** 2026-08-23
