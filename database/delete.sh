#!/bin/bash

# Database Environment Reset Script for Carpooling Project
# This script stops all containers, removes data directories, recreates them with proper permissions,
# and restarts the containers to provide a clean database environment.

# Exit on any error
set -e

# Function to print colored output
print_info() {
    echo -e "\033[1;34m[INFO]\033[0m $1"
}

print_success() {
    echo -e "\033[1;32m[SUCCESS]\033[0m $1"
}

print_warning() {
    echo -e "\033[1;33m[WARNING]\033[0m $1"
}

print_error() {
    echo -e "\033[1;31m[ERROR]\033[0m $1"
}

# Check if docker compose is available
if ! command -v docker &> /dev/null; then
    print_error "Docker is not installed or not in PATH"
    exit 1
fi

if ! docker compose version &> /dev/null; then
    print_error "Docker Compose is not available"
    exit 1
fi

# Check if compose.yaml exists
if [ ! -f "compose.yaml" ]; then
    print_error "compose.yaml file not found in current directory"
    print_info "Please run this script from the database directory"
    exit 1
fi

print_info "Starting database environment reset..."
print_warning "This will remove ALL existing database data!"
read -p "Are you sure you want to continue? (y/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_info "Operation cancelled by user"
    exit 0
fi

# Paths to the database data directories (must match compose.yaml volume mappings)
ORACLE_DATA_DIR="./data/oracle/oradata"
ORACLE_TABLESPACE_DIR="./data/oracle/tablespaces"
DATA_ROOT_DIR="./data"

# Stop all containers defined in the docker-compose file
print_info "Stopping Docker containers..."
docker compose down

# Remove any orphaned volumes to prevent permission issues
print_info "Removing Docker volumes and networks..."
docker compose down -v --remove-orphans 2>/dev/null || true

# Remove the database data directories
print_info "Removing database data directories..."
if [ -d "$ORACLE_DATA_DIR" ]; then
    print_info "  - Removing Oracle data directory: $ORACLE_DATA_DIR"
    rm -rf $ORACLE_DATA_DIR
else
    print_info "  - Oracle data directory not found (already clean)"
fi

if [ -d "$ORACLE_TABLESPACE_DIR" ]; then
    print_info "  - Removing Oracle tablespace directory: $ORACLE_TABLESPACE_DIR"
    rm -rf $ORACLE_TABLESPACE_DIR
else
    print_info "  - Oracle tablespace directory not found (already clean)"
fi

# Note: MariaDB uses Docker's default volume management, no local directories to clean

# Create new database data directories with proper structure
print_info "Creating new database data directories..."
print_info "  - Creating Oracle data directory: $ORACLE_DATA_DIR"
mkdir -p $ORACLE_DATA_DIR
print_info "  - Creating Oracle tablespace directory: $ORACLE_TABLESPACE_DIR"
mkdir -p $ORACLE_TABLESPACE_DIR

# Set appropriate permissions for the directories (Oracle runs as user 1000:1000)
print_info "Setting permissions for database directories..."

# Ensure the data root directory exists and has proper permissions
if [ ! -d "$DATA_ROOT_DIR" ]; then
    print_info "  - Creating data root directory: $DATA_ROOT_DIR"
    mkdir -p "$DATA_ROOT_DIR"
fi

print_info "  - Setting ownership to 1000:1000 for Oracle data directory"
if ! chown -R 1000:1000 "$ORACLE_DATA_DIR" 2>/dev/null; then
    print_warning "  - Could not set ownership (may require sudo). Trying with sudo..."
    if ! sudo chown -R 1000:1000 "$ORACLE_DATA_DIR" 2>/dev/null; then
        print_error "  - Failed to set ownership for Oracle data directory"
        print_info "  - You may need to run this script with sudo or fix permissions manually"
    fi
fi

print_info "  - Setting ownership to 1000:1000 for Oracle tablespace directory"
if ! chown -R 1000:1000 "$ORACLE_TABLESPACE_DIR" 2>/dev/null; then
    print_warning "  - Could not set ownership (may require sudo). Trying with sudo..."
    if ! sudo chown -R 1000:1000 "$ORACLE_TABLESPACE_DIR" 2>/dev/null; then
        print_error "  - Failed to set ownership for Oracle tablespace directory"
        print_info "  - You may need to run this script with sudo or fix permissions manually"
    fi
fi

# Set proper permissions (755 for directories)
print_info "  - Setting directory permissions to 755"
chmod -R 755 "$ORACLE_DATA_DIR" 2>/dev/null || sudo chmod -R 755 "$ORACLE_DATA_DIR" 2>/dev/null || true
chmod -R 755 "$ORACLE_TABLESPACE_DIR" 2>/dev/null || sudo chmod -R 755 "$ORACLE_TABLESPACE_DIR" 2>/dev/null || true

# Start the containers in detached mode
print_info "Starting Docker containers..."
docker compose up -d

echo ""
print_success "================================================================"
print_success "Database environment has been reset successfully!"
print_success "================================================================"
echo ""
print_info "Services started:"
print_info "  - Oracle Database XE 11g (oracle-db-carpooling)"
print_info "  - MariaDB (mariadb-carpooling)"
print_info "  - Adminer Web Interface (adminer-carpooling)"
echo ""
print_info "You can now:"
print_info "  1. Access Adminer at: http://localhost:8080"
print_info "  2. Connect to Oracle using: system/carpooling@172.99.0.2:1521/XE"
print_info "  3. Connect to MariaDB using: root/carpooling@172.99.0.3:3306"
echo ""
print_info "To monitor the startup process, run:"
print_info "  docker compose logs -f"
echo ""
print_warning "Note: It may take a few moments for the databases to be fully ready"
print_info "Check container status with: docker compose ps"