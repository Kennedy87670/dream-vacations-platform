#!/bin/bash

# Dream Vacations Platform - Environment Setup Script
# This script installs all dependencies for local development
# Idempotent: safe to run multiple times

set -e  # Exit on any error

echo "🚀 Starting Dream Vacations Platform setup..."


# Check and install Node.js
echo "📦 Checking Node.js..."
if command -v node &> /dev/null; then
    NODE_VERSION=$(node -v)
    echo "✅ Node.js already installed: $NODE_VERSION"
else
    echo "⚠️  Node.js not found. Installing..."
    # On macOS with Homebrew
    if command -v brew &> /dev/null; then
        brew install node
        echo "✅ Node.js installed"
    else
        echo "❌ Homebrew not found. Please install Homebrew first: https://brew.sh"
        exit 1
    fi
fi


# Check and install Docker
echo "📦 Checking Docker..."
if command -v docker &> /dev/null; then
    DOCKER_VERSION=$(docker --version)
    echo "✅ Docker already installed: $DOCKER_VERSION"
else
    echo "⚠️  Docker not found. Installing..."
    if command -v brew &> /dev/null; then
        brew install docker
        echo "✅ Docker installed"
    else
        echo "❌ Homebrew not found. Please install Docker manually: https://docs.docker.com/get-docker/"
        exit 1
    fi
fi

# Check and install Docker Compose
echo "📦 Checking Docker Compose..."
if command -v docker-compose &> /dev/null; then
    DC_VERSION=$(docker-compose --version)
    echo "✅ Docker Compose already installed: $DC_VERSION"
else
    echo "⚠️  Docker Compose not found. Installing..."
    if command -v brew &> /dev/null; then
        brew install docker-compose
        echo "✅ Docker Compose installed"
    else
        echo "❌ Please install Docker Compose manually: https://docs.docker.com/compose/install/"
        exit 1
    fi
fi


# Check and install PostgreSQL client
echo "📦 Checking PostgreSQL client..."
if command -v psql &> /dev/null; then
    PG_VERSION=$(psql --version)
    echo "✅ PostgreSQL client already installed: $PG_VERSION"
else
    echo "⚠️  PostgreSQL client not found. Installing..."
    if command -v brew &> /dev/null; then
        brew install postgresql
        echo "✅ PostgreSQL client installed"
    else
        echo "❌ Please install PostgreSQL manually: https://www.postgresql.org/download/"
        exit 1
    fi
fi


# Create necessary directories
echo "📁 Creating project directories..."
mkdir -p ./logs
mkdir -p ./backups
chmod 755 ./logs ./backups

# Final summary
echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Create .env file: cp .env.example .env"
echo "2. Start the stack: docker-compose up -d"
echo "3. Access the app: http://localhost:3000"
echo ""
echo "🎉 Happy coding!"
