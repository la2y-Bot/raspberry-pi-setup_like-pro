#!/bin/bash

# Raspberry Pi Initial Setup Script
# This script automates the initial configuration of a Raspberry Pi
# including system updates, dependency installation, and repo cloning

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="${1:-https://github.com/la2y-Bot/raspberry-pi-setup_like-pro.git}"
REPO_DIR="${HOME}/raspberry-pi-setup_like-pro"

# Function to print colored messages
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running as root (recommended for setup)
if [ "$EUID" -ne 0 ] && [ "$SUDO_USER" == "" ]; then
    log_warn "This script should be run with sudo for best results."
    log_info "Run: sudo bash $0"
fi

echo "==========================================="
echo "Welcome to Raspberry Pi Initial Setup"
echo "==========================================="
echo ""

# Step 1: Update system packages
log_info "Step 1: Updating system packages..."
sudo apt-get update
sudo apt-get upgrade -y
log_info "✅ System packages updated"
echo ""

# Step 2: Install essential dependencies
log_info "Step 2: Installing essential dependencies..."
sudo apt-get install -y \
    git \
    python3 \
    python3-pip \
    python3-dev \
    build-essential \
    curl \
    wget \
    nano \
    vim
log_info "✅ Essential dependencies installed"
echo ""

# Step 3: Install RPi.GPIO (if GPIO operations needed)
log_info "Step 3: Installing RPi.GPIO and related packages..."
sudo apt-get install -y python3-rpi.gpio
sudo pip3 install RPi.GPIO --break-system-packages 2>/dev/null || sudo pip3 install RPi.GPIO
log_info "✅ GPIO libraries installed"
echo ""

# Step 4: Clone repository
log_info "Step 4: Cloning repository..."
if [ -d "$REPO_DIR" ]; then
    log_warn "Repository directory already exists. Pulling latest changes..."
    cd "$REPO_DIR"
    git pull origin main || git pull origin master
else
    git clone "$REPO_URL" "$REPO_DIR"
    cd "$REPO_DIR"
fi
log_info "✅ Repository cloned/updated at: $REPO_DIR"
echo ""

# Step 5: Install Python dependencies (if requirements.txt exists)
if [ -f "$REPO_DIR/requirements.txt" ]; then
    log_info "Step 5: Installing Python dependencies..."
    sudo pip3 install -r "$REPO_DIR/requirements.txt" --break-system-packages || sudo pip3 install -r "$REPO_DIR/requirements.txt"
    log_info "✅ Python dependencies installed"
else
    log_warn "Step 5: No requirements.txt found, skipping Python dependency installation"
fi
echo ""

# Step 6: Configure GPIO permissions
log_info "Step 6: Configuring GPIO permissions..."
if ! id -Gn "$SUDO_USER" 2>/dev/null | grep -q gpio; then
    sudo usermod -aG gpio "$SUDO_USER"
    log_info "✅ GPIO group permissions added for user: $SUDO_USER"
else
    log_info "✅ GPIO permissions already configured"
fi
echo ""

# Step 7: Enable SPI and I2C (if needed for hardware)
log_info "Step 7: Checking hardware interfaces..."
if command -v raspi-config &> /dev/null; then
    log_info "raspi-config found. For full hardware setup (SPI, I2C, SSH),"
    log_info "run: sudo raspi-config"
else
    log_warn "raspi-config not found. Install with: sudo apt-get install raspi-config"
fi
echo ""

# Step 8: Make scripts executable
log_info "Step 8: Setting script permissions..."
if [ -d "$REPO_DIR/setup/Linux" ]; then
    chmod +x "$REPO_DIR/setup/Linux"/*.sh 2>/dev/null || true
    log_info "✅ Linux setup scripts are now executable"
fi
if [ -f "$REPO_DIR/project/blink_led.py" ]; then
    chmod +x "$REPO_DIR/project/blink_led.py" 2>/dev/null || true
fi
echo ""

# Final summary
echo "==========================================="
echo "✅ Initial Setup Complete!"
echo "==========================================="
echo ""
echo "Next steps:"
echo "  1. Repository location: $REPO_DIR"
echo "  2. Run LED test: python3 $REPO_DIR/project/blink_led.py"
echo "  3. Configure hardware: sudo raspi-config"
echo "  4. Check IP address: hostname -I"
echo ""
echo "For more information, check the README.md in the repository."
echo "" 
