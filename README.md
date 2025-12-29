# raspberry-pi-setup_like-pro
A practical, opinionated collection of scripts and notes to set up a Raspberry Pi "like a pro" — flashing OS, enabling Wi‑Fi, updating packages, and small example projects.

Repository: https://github.com/la2y-Bot/raspberry-pi-setup_like-pro.git

**What this repo contains**

- **Overview**: automation and helper scripts to bootstrap a Raspberry Pi for development and simple projects.
- **Quick goal**: get a Raspberry Pi up-to-date, configured for Wi‑Fi, and running the example `blink_led` project.

**Prerequisites**

- A Raspberry Pi (any modern model) with a microSD card (8 GB+ recommended).
- A computer to flash the SD card (Windows/macOS/Linux).
- Raspberry Pi Imager (recommended) or `dd` for flashing images.
- Basic command-line familiarity and a USB power supply for the Pi.

**Quickstart**

1. Clone this repository:

   git clone https://github.com/la2y-Bot/raspberry-pi-setup_like-pro.git
   cd raspberry-pi-setup_like-pro

2. Flash Raspberry Pi OS to your SD card using Raspberry Pi Imager (recommended).

3. Boot the Pi from the SD card and enable SSH (via Raspberry Pi Imager advanced options or by creating an empty `ssh` file on the boot partition).

4. Copy this repo to the Pi (optional) or work from another host via SSH.

5. Linux automated helper scripts:

   - To install / prepare an OS image and setup basic packages, see [setup/Linux/installe_os.sh](setup/Linux/installe_os.sh).
   - To update packages, run: `sudo bash setup/Linux/update_packages.sh`.
   - To configure Wi‑Fi from the command line, see: [setup/Linux/wifi_config.sh](setup/Linux/wifi_config.sh).

   Example (on the Pi):

   sudo bash setup/Linux/update_packages.sh

6. GUI or Windows notes: the `setup/window/setup_guid.md` document describes Windows-specific steps and tips: [setup/window/setup_guid.md](setup/window/setup_guid.md).

**Repository structure**

- [raspberry_pi_setup.sh](raspberry_pi_setup.sh) — high-level orchestration script (review before running).
- [project/blink_led.py](project/blink_led.py) — simple example to blink an LED using GPIO.
- [setup/Linux/installe_os.sh](setup/Linux/installe_os.sh) — scripts for initial OS installation tasks.
- [setup/Linux/update_packages.sh](setup/Linux/update_packages.sh) — keep the system up-to-date.
- [setup/Linux/wifi_config.sh](setup/Linux/wifi_config.sh) — preconfigure Wi‑Fi from shell.
- [setup/window/setup_guid.md](setup/window/setup_guid.md) — Windows setup notes and instructions.

**Using the `blink_led` example**

1. Ensure you run this on a Raspberry Pi with GPIO support enabled.
2. Connect a LED (with a proper resistor, e.g., 220Ω) to a GPIO pin (example below uses GPIO 17) and ground.

   - LED long leg → GPIO 17
   - LED short leg → resistor → GND

3. Run the example:

   python3 project/blink_led.py

4. If the script uses libraries such as `gpiozero` or `RPi.GPIO` they must be installed. On the Pi, install common libs:

   sudo apt update && sudo apt install -y python3-pip
   pip3 install gpiozero

If the script in `project/blink_led.py` requires different packages, install them as instructed inside the file.

**Security & safety**

- Always review any script before running it with `sudo`.
- Back up important data before running installer scripts that modify partitions or re-image SD cards.

**Troubleshooting**

- If Wi‑Fi doesn't connect: verify SSID/password in `setup/Linux/wifi_config.sh` and check country code settings.
- If GPIO code fails: ensure `gpio` access (run as root or use `gpiozero` with proper permissions) and that wiring is correct.

**Contributing**

- Suggestions, fixes, and additional setup scripts are welcome. Open an issue or a pull request.
- Aim for small, well-documented changes.

**License**

This repository includes a `LICENSE` file at the project root. Follow the license terms when reusing code.

---

If you want, I can also:

- Create a `requirements.txt` for the Python project and add a short test harness for `blink_led.py`.
- Add checks to the main scripts to avoid running destructive operations accidentally.

File updated: [README.md](README.md)
You’ll also find example projects to get started with GPIO and Python.

---
