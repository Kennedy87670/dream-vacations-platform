#!/bin/bash
set -e

echo "Starting Dream Vacations Platform deployment..."

# Update system
apt-get update
apt-get upgrade -y

# Install Docker
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Install Docker Compose standalone
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Start Docker
systemctl start docker
systemctl enable docker

# Add ubuntu user to docker group
usermod -aG docker ubuntu

# Create app directory
mkdir -p /home/ubuntu/dream-vacations-platform
cd /home/ubuntu/dream-vacations-platform

# Create docker-compose.yml
cat > docker-compose.yml << 'DOCKER_EOF'
version: '3.8'

services:
  db:
    image: postgres:16-alpine
    container_name: dream-vacations-db
    environment:
      POSTGRES_USER: dreamvacations
      POSTGRES_PASSWORD: secure-password
      POSTGRES_DB: dream_vacations_db
    volumes:
      - db_data:/var/lib/postgresql/data
    ports:
      - "5433:5432"
    restart: unless-stopped

  backend:
    image: DOCKER_USERNAME/dream-vacations-backend:latest
    container_name: dream-vacations-backend
    environment:
      NODE_ENV: production
      PORT: 5000
      DB_HOST: db
      DB_PORT: 5432
      DB_USER: dreamvacations
      DB_PASSWORD: secure-password
      DB_NAME: dream_vacations_db
    ports:
      - "5001:5000"
    depends_on:
      - db
    restart: unless-stopped

  frontend:
    image: DOCKER_USERNAME/dream-vacations-frontend:latest
    container_name: dream-vacations-frontend
    ports:
      - "3000:3000"
    environment:
      REACT_APP_API_URL: http://localhost:5001
    restart: unless-stopped

volumes:
  db_data:
DOCKER_EOF

# Replace DOCKER_USERNAME placeholder
sed -i 's/DOCKER_USERNAME/your-docker-username/g' docker-compose.yml

# Start services
docker-compose up -d

# Wait for services to start
sleep 10

echo "✅ Dream Vacations Platform deployed successfully!"
echo "Access at: http://$(hostname -I | awk '{print $1}')"
