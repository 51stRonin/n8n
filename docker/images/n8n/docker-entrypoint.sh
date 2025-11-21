#!/bin/sh

set -e

# ---------------------------------------
# n8n Render-Optimized Entrypoint
# ---------------------------------------

# Make sure correct timezone is set
if [ -n "$GENERIC_TIMEZONE" ]; then
    export TZ=$GENERIC_TIMEZONE
fi

# Avoid Render sleep crash
export N8N_DISABLE_PRODUCTION_MAIN_PROCESS=true

# Create necessary folders
mkdir -p /home/node/.n8n
mkdir -p /files

# Run database migrations before starting n8n
echo "Running database migrations..."
n8n migrate:latest || true

echo "Starting n8n..."
exec n8n start --tunnel
