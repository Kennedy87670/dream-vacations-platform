#!/bin/bash

# Dream Vacations Platform - Log Rotation Script
# Compresses older logs and removes expired archives

set -e

LOG_DIR="./logs"
COMPRESS_AGE_DAYS=7
DELETE_AGE_DAYS=30

echo "📋 Starting log rotation..."

mkdir -p "$LOG_DIR"

compress_logs() {
  find "$LOG_DIR" -type f -name "*.log" ! -name "*.gz" | while read -r file; do
    FILE_AGE_DAYS=$(( ( $(date +%s) - $(stat -f %m "$file" 2>/dev/null || stat -c %Y "$file") ) / 86400 ))

    if [ "$FILE_AGE_DAYS" -ge "$COMPRESS_AGE_DAYS" ]; then
      echo "🗜️  Compressing $(basename "$file")"
      gzip -f "$file"
    fi
  done
}

delete_old_archives() {
  find "$LOG_DIR" -type f -name "*.gz" | while read -r file; do
    FILE_AGE_DAYS=$(( ( $(date +%s) - $(stat -f %m "$file" 2>/dev/null || stat -c %Y "$file") ) / 86400 ))

    if [ "$FILE_AGE_DAYS" -ge "$DELETE_AGE_DAYS" ]; then
      echo "🗑️  Removing expired archive $(basename "$file")"
      rm -f "$file"
    fi
  done
}

compress_logs
delete_old_archives

echo "✅ Log rotation complete"
