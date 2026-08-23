#!/bin/bash

# Dream Vacations Platform - Log Rotation Script
# Compresses old logs and removes very old ones
# Runs daily via cron

# shellcheck disable=SC2034
set -e

LOG_DIR="./logs"
COMPRESS_AGE_DAYS=7
DELETE_AGE_DAYS=30


echo "📋 Starting log rotation..."

# Create logs directory if it doesn't exist
mkdir -p "$LOG_DIR"


#!/bin/bash

# Dream Vacations Platform - Log Rotation Script
# Compresses old logs and removes very old ones
# Runs daily via cron

set -e

LOG_DIR="./logs"
COMPRESS_AGE_DAYS=7
DELETE_AGE_DAYS=30

echo "📋 Starting log rotation..."

# Create logs directory if it doesn't exist
mkdir -p "$LOG_DIR"
