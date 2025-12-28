#!/bin/bash
# update_packages.sh - Update Raspberry Pi packages

set -e
    
echo "=== Updating Raspberry Pi Packages ==="
sudo apt update && sudo apt upgrade -y
sudo apt update python
sudo apt autoremove -y

echo "✅ System updated successfully!"
