# Dream Vacations Platform

## Overview

A full-stack travel booking web application deployed on AWS with containerization, CI/CD pipelines, and infrastructure-as-code. The platform demonstrates production-ready DevOps practices including automated deployments, SSL security, and monitoring.

## Architecture

```
┌─────────────────────────────────────────────────────┐
│                    Internet                         │
└────────────────────────┬────────────────────────────┘
                         │
                  ┌──────▼──────────────┐
                  │  DuckDNS Subdomain  │
                  │   (DNS Resolution)  │
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
| Cloud | AWS (EC2, VPC, optional Route 53-ready Terraform) |
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
# Backend API: http://localhost:5001
# Database: localhost:5433
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
| `REACT_APP_API_URL` | Backend API URL | `http://localhost:5001` or blank for same-origin proxy | ✓ |
| `REACT_APP_API_URL_PROD` | Production API URL | `https://kennedy-dreamvacation.duckdns.org` | ✓ |

## Deployment Checklist

### Section 1: Git & Repository Setup
- [x] Create public GitHub repository
- [x] Set up `main` and `dev` branches
- [x] Configure branch protection on `main`
- [x] Write README skeleton

### Section 2: Shell Scripting
- [x] Write environment setup script
- [x] Write database backup script
- [x] Write log rotation script
- [ ] Test idempotency

### Section 3: Containerization
- [x] Create backend Dockerfile
- [x] Create frontend Dockerfile
- [ ] Verify images build successfully
- [ ] Test containers run independently

### Section 4: Docker Compose
- [x] Write docker-compose.yml
- [x] Define all services (frontend, backend, database)
- [x] Configure networking and volumes
- [ ] Test full stack with one command

### Section 5: CI/CD (GitHub Actions)
- [x] Create CI workflow (PR builds/tests)
- [x] Create CD workflow (merge to main)
- [x] Push Docker images to registry
- [ ] Add status badges to README

### Section 6: Terraform (AWS Infrastructure)
- [x] Create VPC and subnets
- [x] Configure security groups
- [x] Set up Route 53 hosted zone
- [x] Configure remote state
- [x] Validate with `terraform plan`

### Section 7: AWS Deployment
- [x] Provision EC2 instance
- [x] SSH access and deployment
- [x] Verify app accessible by public IP

### Section 8: Domain & DNS
- [x] Register free domain
- [ ] Create Route 53 hosted zone
- [ ] Update nameservers at registrar
- [x] Create A record to EC2

### Section 9: Nginx & SSL
- [x] Install and configure Nginx
- [x] Set up reverse proxy rules
- [x] Install Let's Encrypt certificate
- [x] Configure auto-renewal
- [x] Verify HTTPS access

### Section 10: Stretch Goals
- [ ] CloudWatch monitoring setup
- [ ] Application logging
- [ ] Performance dashboards

## Project Status

**Current Phase:** Sections 8 and 9 completed with DuckDNS + HTTPS

**Next Steps:** 
1. Add README status badges
2. Push the final code and documentation updates
3. Organize screenshots for submission
4. Prepare the demo/presentation walkthrough

## Deployment Evidence

The following evidence has been completed and should be saved in `img/` or another screenshots folder for submission:

- Terraform `apply` completed successfully and returned EC2 public IP output.
- SSH login to the EC2 instance succeeded with the configured key pair.
- Docker Engine and Docker Compose were installed and running on EC2.
- Project files were copied to `/home/ubuntu/dream-vacations-platform` on the EC2 host.
- `docker compose -f docker-compose.ec2.yml up -d --build` started the database, backend, and frontend containers.
- `curl http://localhost/api/destinations` returned `[]`, confirming backend to database connectivity.
- The browser successfully loaded the app from the EC2 public IP and add/delete actions worked.
- DuckDNS was pointed to the EC2 instance public IP.
- Nginx reverse proxy was configured on the EC2 host.
- Certbot successfully issued and installed an HTTPS certificate for the DuckDNS hostname.
- The application was verified over HTTPS at the final live URL.

Suggested screenshot names:

- `terraform-apply.png`
- `ssh-login.png`
- `docker-status.png`
- `ec2-project-files.png`
- `docker-compose-ps.png`
- `api-destinations.png`
- `app-added-destination.png`
- `app-delete-destination.png`
- `duckdns-domain.png`
- `nginx-test.png`
- `certbot-success.png`
- `https-live-app.png`

## AWS Deployment Notes

The beginner deployment path used in this project is:

1. Provision infrastructure with Terraform.
2. SSH into the EC2 instance with the configured SSH key.
3. Copy the application files to the server.
4. Build and run the stack with `docker compose -f docker-compose.ec2.yml up -d --build`.
5. Verify the frontend at the EC2 public IP and verify backend/database connectivity with the API.

Current verified public URL during testing:

- `http://44.223.15.124`
- `https://kennedy-dreamvacation.duckdns.org`

## Domain And DNS Notes

Amazon Route 53 is the AWS service normally used for:

- registering a domain name
- hosting DNS records
- pointing your domain to the EC2 public IP

For this capstone submission, a free DuckDNS subdomain was used instead:

- `kennedy-dreamvacation.duckdns.org`

Reason:

- DuckDNS provides a free subdomain and direct IP mapping.
- DuckDNS does not allow custom nameserver delegation for its parent zone.
- Because of that limitation, live DNS for this deployment is handled by DuckDNS rather than an Amazon Route 53 hosted zone.

Terraform remains Route 53-ready if a paid custom domain is added later. At that point, the hosted zone and Route 53 record resources can be used without redesigning the infrastructure.

The live DNS steps completed for this project were:

1. Create the DuckDNS subdomain.
2. Point the subdomain to the EC2 public IP.
3. Verify DNS resolution with `nslookup`.
4. Configure Nginx on EC2.
5. Issue an SSL certificate with Certbot and Let's Encrypt.
6. Verify the site over HTTPS.

## Live Deployment

Final production-style URL:

- `https://kennedy-dreamvacation.duckdns.org`

Deployment path used:

1. Provision infrastructure with Terraform.
2. Deploy the app to EC2 with Docker Compose.
3. Point DuckDNS to the EC2 public IP.
4. Move frontend traffic behind host-level Nginx.
5. Secure the domain with Let's Encrypt.

## Known Issues And Fixes

- The original backend relied on the legacy `restcountries` API endpoint. On August 31, 2026, that legacy API returned a deprecation response instead of country data.
- To keep the capstone deployment working, the backend now includes a fallback dataset for common countries such as Canada, Nigeria, France, Japan, Germany, Ghana, Kenya, Brazil, United States, and United Kingdom.
- The database initialization file was corrected to create the `destinations` table used by the Node.js backend.
- The shell scripts were cleaned up so backup and log rotation behave consistently.

## Getting Help

- Review the assignment requirements in the project documentation
- Check Docker Compose logs: `docker-compose logs <service>`
- Verify environment variables: `docker-compose config`
- Test API endpoints: `curl -vI http://localhost/api/health`

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Let's Encrypt](https://letsencrypt.org/)
- [Nginx Documentation](https://nginx.org/en/docs/)

---

**Author:** Kennedy (Junior DevOps Engineer)  
**Last Updated:** 2026-08-31
