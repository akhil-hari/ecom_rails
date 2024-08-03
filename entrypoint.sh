#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /ecom_rails/tmp/pids/server.pid

# Wait for the PostgreSQL server to be ready
until pg_isready -h db -U ecom_rails; do
  sleep 1
done

# Execute the container's main process (set as CMD in the Dockerfile).
exec "$@"
