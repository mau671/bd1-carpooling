#!/bin/bash

# Path to the oracle data directory
ORACLE_DATA_DIR="./data/"
ORACLE_TABLESPACE_DIR="./tablespaces/"

# Stop all containers defined in the docker-compose file
echo "Stopping Docker containers..."
docker compose down

# Remove the oracle data directory
echo "Removing Oracle data directory..."
rm -rf $ORACLE_DATA_DIR
rm -rf $ORACLE_TABLESPACE_DIR

# Create a new oracle data directory
echo "Creating new Oracle data directory..."
mkdir -p $ORACLE_DATA_DIR
mkdir -p $ORACLE_TABLESPACE_DIR

# Set appropriate permissions for the directory
echo "Setting permissions for Oracle data directory..."
chown -R 1000:1000 $ORACLE_DATA_DIR
chown -R 1000:1000 $ORACLE_TABLESPACE_DIR

# Start the containers in detached mode
echo "Starting Docker containers..."
docker compose up -d

echo "Environment has been reset successfully."