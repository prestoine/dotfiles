#!/bin/bash

domains=(desouzafernandez.com crosbyhomeservices.org cityofreklaw.org)
email="your-email@example.com" # Replace with your email

for domain in "${domains[@]}"; do
  docker compose run --rm certbot certonly --webroot \
    --webroot-path=/var/www/certbot \
    --email $email \
    --agree-tos \
    --no-eff-email \
    --staging \  # Remove this flag in production
    -d $domain \
    -d *.$domain
done

# Reload nginx to pick up the new certificates
docker compose exec nginx nginx -s reload
