#!/bin/bash
# wifi_config.sh - Configure Wi-Fi for Raspberry Pi

set -e

echo "=== Wi-Fi Configurator ==="

read -p "Enter Wi-Fi SSID: " SSID
read -sp "Enter Wi-Fi Password: " PASSWORD
echo

WPA_FILE="/etc/wpa_supplicant/wpa_supplicant.conf"

sudo bash -c "cat > $WPA_FILE <<EOF
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=US

network={
    ssid=\"$SSID\"
    psk=\"$PASSWORD\"
}
EOF"

echo "✅ Wi-Fi configuration updated. Reboot to apply."
