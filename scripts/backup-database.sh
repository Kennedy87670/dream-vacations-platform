#!/bin/bash

# Dream Vacations Platform - Database Backup Script
# Creates compressed PostgreSQL backups with automatic retention
# Backs up to ./backups/ directory

set -e

BACKUP_DIR="./backups"
DB_NAME="${DB_NAME:-dream_vacations_db}"
DB_USER="${DB_USER:-dreamvacations}"
DB_HOST="${DB_HOST:-localhost}"
DB_PASSWORD="${DB_PASSWORD:-}"
RETENTION_DAYS=7

echo "💾 Starting database backup..."


# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Generate timestamp for backup filename
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="$BACKUP_DIR/backup_${DB_NAME}_${TIMESTAMP}.sql.gz"

# Check if database exists
echo "📋 Checking database connection..."
if ! PGPASSWORD="$DB_PASSWORD" psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -c "\q" 2>/dev/null; then
    echo "❌ Error: Cannot connect to database $DB_NAME"
    echo "Make sure Docker container is running: docker-compose up -d"
    exit 1
fi

# Create backup
echo "💾 Creating backup: $BACKUP_FILE"
if PGPASSWORD="$DB_PASSWORD" pg_dump -h "$DB_HOST" -U "$DB_USER" "$DB_NAME" | gzip > "$BACKUP_FILE"; then
    echo "✅ Backup created successfully"

else
    echo "❌ Backup failed"
    exit 1
fi


# Clean up old backups
echo "🧹 Cleaning up backups older than $RETENTION_DAYS days..."
CUTOFF_DATE=$(date -d "$RETENTION_DAYS days ago" +%s 2>/dev/null || date -v-${RETENTION_DAYS}d +%s)

find "$BACKUP_DIR" -name "backup_*.sql.gz" -type f | while read -r file; do
    FILE_DATE=$(stat -f %m "$file" 2>/dev/null || stat -c %Y "$file")
    
    if [ "$FILE_DATE" -lt "$CUTOFF_DATE" ]; then
        echo "🗑️  Removing old backup: $(basename "$file")"
        rm "$file"
    fi
done

# Show remaining backups
echo ""
echo "📊 Current backups:"
ls -lh "$BACKUP_DIR"/backup_*.sql.gz 2>/dev/null || echo "No backups found"

echo ""
echo "✅ Backup process complete!"
