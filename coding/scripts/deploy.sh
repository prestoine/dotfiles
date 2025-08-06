#!/bin/bash

# Check if running in production
if [ "$1" != "prod" ]; then
  echo "Usage: ./deploy.sh prod"
  exit 1
fi

# Stop all services
docker compose down

# Pull latest changes
git pull

# Build and start services
docker compose up -d

# Initialize certificates if they don't exist
if [ ! -d "frontend/nginx/ssl/live" ]; then
  ./scripts/init-certs.sh
fi
