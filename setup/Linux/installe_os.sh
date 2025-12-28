#!/bin/bash
# install_os.sh - Flash Raspberry Pi OS to SD card

# Exit on error
set -e

echo "=== Raspberry Pi OS Installer ==="

# Check arguments
if [ $# -ne 2 ]; then
  echo "Usage: $0 <path-to-img> <device>"
  echo "Example: $0 ~/Downloads/raspios.img /dev/sdX"
  exit 1
fi

IMG=$1
DEVICE=$2

echo "Flashing $IMG to $DEVICE..."
sudo dd if=$IMG of=$DEVICE bs=4M status=progress conv=fsync

echo "Syncing..."
sync

echo "✅ Installation complete! Insert SD card into Raspberry Pi."
